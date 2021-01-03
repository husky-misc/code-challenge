from django.contrib import admin

from cartao.models import Cc


class CcAdmin(admin.ModelAdmin):
    list_display = [
        'fullname',
        'name_flag',
        'spent_limit',
        'number',
        'expiration_date',
        'cvv_code',
    ]


admin.site.register(Cc, CcAdmin)
