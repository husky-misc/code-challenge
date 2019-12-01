class Transaction < ApplicationRecord
    belongs_to :bank_statement, touch: true, optional: true
    
    def i18n
        I18n.default_locale
    end

    def as_json(options={})
        super(methods: :i18n, root: true)
    end

end
