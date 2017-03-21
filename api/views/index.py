# coding=utf-8
from django.http import JsonResponse


def index(request):
    return JsonResponse({"status": "Hello World"})
