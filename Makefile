## Variables
VIRTUALENV_DIR := .virtualenv
PYTHON_VER := 3.6
KEY=$(shell openssl rand -hex 12)

.PHONY: secret venv serve migrate su check

## Targets

# Cleanup
clean:
	@echo '💩  CleanUp'
	@find . -name "*.pyc" -delete
	@rm -f .coverage
	@rm -rf .cache __pycache__

# DB
rmdb:
	@echo '💣  Drop Database'
	@find . -name "*.sqlite*" -delete

# PYTHON

#pip
pip:
	@echo '✅  Install Requirements'
	@pip install -U -r requirements.txt
freeze:
	@echo '❄️  Freezing'
	@pip freeze | tr A-Z a-z | sort > requirements.txt

# virtualenv
mkvenv:
	@echo '🎉  New Virtualenv'
	@virtualenv $(VIRTUALENV_DIR) --python=python$(PYTHON_VER)
rmvenv:
	@echo '💀  Delete Virtualenv'
	@rm -rf $(VIRTUALENV_DIR)
venv:
	@echo '✋️  Virtualenv Active'
	@source $(VIRTUALENV_DIR)/bin/activate

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
	@echo '😎  New Secret Key'
	@sed -i '' -- "s/SECRET_KEY.*/SECRET_KEY = \'${KEY}\'/g" config/settings.py

## Chains

install: secret mkvenv pip migrate check su
update: clean pip migrate check
fresh: clean rmvenv rmdb install
kill: clean rmvenv rmdb
