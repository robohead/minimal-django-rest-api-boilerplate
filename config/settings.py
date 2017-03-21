# coding=utf-8
import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DEBUG = True,
ROOT_URLCONF = 'config.urls'
SECRET_KEY = '0758bbf505ed1f5d28470b72'
WSGI_APPLICATION = 'config.wsgi.application'

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    # third party apps
    'rest_framework',
    # local apps
    'api',
)

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3', 'NAME': 'db.sqlite3'
    },
}

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
)
