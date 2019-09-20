"""day19 URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
# from app01 import views as V1
# from app02 import views as V2
from django.conf.urls import url,include
from app02 import views


urlpatterns = [

    url(r'^cmdb/', include("app01.urls")),
    url(r'^monitor/', include("app02.urls")),

]





'''
urlpatterns = [
    
    path('admin/', admin.site.urls),
    url(r' ^asdfdsgfdgd/(\d+)/', views.index, name='indexx'),
    path('login/', views.login),
    path('home/', views.Home.as_view()),
#    path('detail/', views.detail),
    url(r'^detail-(\d+).html', views.detail),
    url(r'^detail-(?P<nid>\d+)-(?P<uid>\d+).html', views.detail),
   
]
'''