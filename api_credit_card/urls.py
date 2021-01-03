"""api_credit_card URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
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
from django.contrib.auth.models import User
from django.urls import path, include
from cartao.models import Cc
from cartao import views


# Routers provide an easy way of automatically determining the URL conf.
from rest_framework import routers, serializers, viewsets


# Serializers define the API representation.
class UserSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = User
        fields = ['url', 'username', 'email']


# ViewSets define the view behavior.
class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer


class CcSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Cc
        fields = [
            'fullname',
            'name_flag',
            'spent_limit',
            'number',
            'expiration_date',
            'cvv_code'
        ]


# ViewSets define the view behavior.
class CcViewSet(viewsets.ModelViewSet):
    queryset = Cc.objects.all()
    serializer_class = CcSerializer


router = routers.DefaultRouter()
router.register(r'users', UserViewSet)
router.register(r'cartoes', CcViewSet)

urlpatterns = [
    # path('', include(router.urls)),
    path('', views.home_page, name='home_page'),
    path('admin/', admin.site.urls),
    path('api-auth/', include('rest_framework.urls')),
    # path('/cartao', include(car.router))
]
