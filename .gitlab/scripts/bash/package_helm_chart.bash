#!/bin/bash
for HELM_PROJECT in $(find . -mindepth 1 -maxdepth 1 -type d ! -name ".*" -exec basename {} \;); do
	if [[ -e "${CI_PROJECT_DIR}/${HELM_PROJECT}/Chart.yaml" ]]; then
		HELM_PROJECT_VERSION="$(yq e '.version' "${CI_PROJECT_DIR}/${HELM_PROJECT}/Chart.yaml")"
		HELM_PACKAGE_LIST=$(curl -s --fail --header --request GET --user "gitlab-ci-token:${CI_JOB_TOKEN}" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/packages?package_type=helm&package_name=${HELM_PROJECT}")
		HELM_PACKAGE_CHECK=$(echo "${HELM_PACKAGE_LIST}" | jq -r --arg JQVERSION "${HELM_PROJECT_VERSION}" '.[] | select( .version == $JQVERSION ) | .version')
		if [[ -n ${HELM_PACKAGE_CHECK} ]]; then
			echo "Helm package ${HELM_PROJECT}-${HELM_PROJECT_VERSION} already exists."
		else
			TAG_CHECK=$(git ls-remote --tags origin -l "${HELM_PROJECT}-${HELM_PROJECT_VERSION}")
			if [[ -n ${TAG_CHECK} ]]; then
				echo "TAG ${HELM_PROJECT}-${HELM_PROJECT_VERSION} already exists"
			else
				helm dependency update "${HELM_PROJECT}" || true
				if [[ -e "${HELM_PROJECT}/values_secrets.yaml" ]]; then
					helm lint "${HELM_PROJECT}" -f "${HELM_PROJECT}/values.yaml" -f "${HELM_PROJECT}/values_secrets.yaml"
					helm template -f "${HELM_PROJECT}/values.yaml" -f "${HELM_PROJECT}/values_secrets.yaml" "${HELM_PROJECT}" >"${HELM_PROJECT}.template"
				else
					helm lint "${HELM_PROJECT}" -f "${HELM_PROJECT}/values.yaml"
					helm template -f "${HELM_PROJECT}/values.yaml" "${HELM_PROJECT}" >"${HELM_PROJECT}.template"
				fi
				if [[ ${CI_COMMIT_BRANCH} =~ ^(master|coog-(([[:digit:]]{1,2}).([[:digit:]]{1,2})))$ ]]; then
					git tag -a "${HELM_PROJECT}-${HELM_PROJECT_VERSION}" -m "Create TAG ${HELM_PROJECT}-${HELM_PROJECT_VERSION}"
					git push "${CI_COMMIT_BRANCH}"
					git push "${HELM_PROJECT}-${HELM_PROJECT_VERSION}"
				fi
				helm package "${HELM_PROJECT}"
				helm repo index --url "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/packages/helm/stable" .
				echo "HELM_NEW_CHART=true" >upload.env
				echo "HELM_PROJECT_VERSION=${HELM_PROJECT_VERSION}" >>upload.env
				curl --request POST --user "gitlab-ci-token:${CI_JOB_TOKEN}" --form "chart=@${HELM_PROJECT}-${HELM_PROJECT_VERSION}.tgz" "${CI_API_V4_URL}/projects/${CI_PROJECT_ID}/packages/helm/api/stable/charts"
			fi
		fi
	else
		echo "Directory ${HELM_PROJECT} doesn't have Chart.yaml"
	fi
done
