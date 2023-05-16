#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

python /usr/src/app/backend/manage.py collectstatic --noinput
python /usr/src/app/backend/manage.py migrate
/usr/local/bin/gunicorn backend.wsgi --bind 0.0.0.0:8000 --chdir=/usr/src/app