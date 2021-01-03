import os

from django.http import HttpRequest

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "api_credit_card.settings")

import django

django.setup()

from django.urls import resolve
from cartao.views import home_page


def test_root_url_resolves_to_home_page():
    found = resolve('/')
    assert found.func == home_page


def test_home_page_returns_correct_html():
    request = HttpRequest()
    response = home_page(request)
    html = response.content.decode('utf8')
    assert html.startswith('<html>') is True
    assert '<title>To-Do lists</title>' in html
    assert html.endswith('</html>') is True
