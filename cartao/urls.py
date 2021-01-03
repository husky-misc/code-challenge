from django.urls import path, include
from rest_framework import routers, serializers, viewsets

from cartao.models import Cc


class CcSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Cc
        fields = ['full_name', 'name_flag', 'number']


# ViewSets define the view behavior.
class CcViewSet(viewsets.ModelViewSet):
    queryset = Cc.objects.all()
    serializer_class = CcSerializer


router = routers.DefaultRouter()
router.register(r'cartoes', CcViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
