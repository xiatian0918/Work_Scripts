from django.contrib import admin
from django.urls import path,include
from django.conf.urls import url
from app01 import views

app_name = 'app01'
urlpatterns = [
    url(r'^index/',views.index,name='index'),
]