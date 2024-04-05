# Helm Unit Test

To test helm chart, we have created many scenario to be sur that everything works.

We perform these tests with the Helm plugin unittest => https://github.com/helm-unittest/helm-unittest

## Requirements

- Helm3 (most recent version if possible)
- Helm plugin unittest => `helm plugin install https://github.com/helm-unittest/helm-unittest`

## Run Tests

Go to base project path and execute the following command :

`helm unittest -f 'tests/**/*.yaml' coog`

For GitLab CI/CD, we want to have an human readable report, we have to use the following command in test job :

`helm unittest -t JUnit -o unit_test_report.xml -f 'tests/**/*.yaml' coog`
