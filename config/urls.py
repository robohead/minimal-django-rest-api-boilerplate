# coding=utf-8
from django.conf.urls import url
from django.conf.urls import include


urlpatterns = [
    url(r'^api/v1/', include('api.urls')),
]
