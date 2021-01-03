from cartao.models import Cc


def test_model_cc_exists():
    cartao = Cc()
    assert cartao != None

def test_attributes_exists():
    cartao = Cc()
    cartao.fullname = None
    assert cartao.fullname == None
