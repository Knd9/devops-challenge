#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

python manage.py makemigrations
python manage.py migrate
DJANGO_SUPERUSER_PASSWORD=$DEFAULT_ADMIN_PASSWORD \
python manage.py createsuperuser --noinput --email \
$DEFAULT_ADMIN_EMAIL --username $DEFAULT_ADMIN_USERNAME || true
python manage.py runserver 0.0.0.0:8000