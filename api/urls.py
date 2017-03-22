# urls.py
from django.conf.urls import url

from .views import index

urlpatterns = [
    url(r'index$', index, name="index"),
]
