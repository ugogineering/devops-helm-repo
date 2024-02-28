#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

GCS_BUCKET_NAME="gs://ugo-bucket-270224"

# setup for helm-gcs plugin
echo "${GCLOUD_SERVICE_ACCOUNT_KEY}" > svc-acc.json
export GOOGLE_APPLICATION_CREDENTIALS=svc-acc.json

# initializing helm repo
# (only needed on first run, but will do nothing if already exists)
echo "Initializing helm repo"
helm gcs init ${GCS_BUCKET_NAME}

# add gcs bucket as helm repo
echo "Adding gcs bucket repo ${GCS_BUCKET_NAME}"
helm repo add private ${GCS_BUCKET_NAME}