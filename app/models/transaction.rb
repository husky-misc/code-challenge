class Transaction < ApplicationRecord
    def i18n
        I18n.default_locale
    end
    def as_json(options={})
        super(methods: :i18n, root: true)
    end
end
