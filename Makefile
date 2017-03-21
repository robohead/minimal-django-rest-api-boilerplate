## Variables
VIRTUALENV_DIR := .virtualenv
PYTHON_VER := 3.6
KEY=$(shell openssl rand -hex 12)

.PHONY: secret venv serve migrate su check

## Targets

# Cleanup
clean:
	find . -name "*.pyc" -delete
	rm -f .coverage
	rm -rf .cache __pycache__

# DB
rmdb:
	find . -name "*.sqlite*" -delete

# PYTHON

#pip
pip:
	pip install -U -r requirements.txt
freeze:
	pip freeze | tr A-Z a-z | sort > requirements.txt

# virtualenv
mkvenv:
	virtualenv $(VIRTUALENV_DIR) --python=python$(PYTHON_VER)
	echo $(VIRTUALENV_DIR) >> .gitignore
rmvenv:
	rm -rf $(VIRTUALENV_DIR)
venv:
	source $(VIRTUALENV_DIR)

# test & lint
test:
	py.test
lint:
	flake8 .

# django
serve:
	python manage.py runserver
migrate:
	python manage.py migrate
migrations:
	python manage.py makemigrations $(app)
su:
	python manage.py createsuperuser
check:
	python manage.py check
shell:
	python manage.py shell

# setings
secret:
	sed -i '' -- "s/SECRET_KEY.*/SECRET_KEY = \'${KEY}\'/g" config/settings.py

## Chains

install: secret mkvenv pip migrate check su
update: clean pip migrate check
fresh: clean rmvenv rmdb install
kill: clean rmvenv rmdb
