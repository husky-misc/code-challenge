# coding=utf-8
from django.db import models

class Cc(models.Model):
    fullname = models.CharField(
        'Nome completo',
        max_length=100,
    )
    name_flag = models.CharField(
        'Bandeira do cartão',
        max_length=100,
        default=''
    )
    spent_limit = models.IntegerField(
        'Limite de gastos'
    )
    number = models.IntegerField(
        'Número do cartão',
    )
    expiration_date = models.DateField(
        'Data de validade'
    )
    cvv_code = models.IntegerField(
        'Código de Segurança'
    )

    def __str__(self):
        return self.fullname

    class Meta:
        verbose_name_plural = 'Cartões de Crédito'
