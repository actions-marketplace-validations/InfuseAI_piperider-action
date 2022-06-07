#!/bin/bash -l
set -o pipefail

export GITHUB_ACTION_URL="https://github.com/${GITHUB_REPOSITORY}/actions/runs/${GITHUB_RUN_ID}"

eval "pip install --no-cache-dir -r ${GITHUB_WORKSPACE}/requirements.txt"
eval piperider-cli run --no-interaction --generate-report | tee output.log ; rc=$?

pushd /usr/src/github-action
/root/.nvm/versions/node/v16.13.0/bin/node index.js $rc || exit $?
popd
