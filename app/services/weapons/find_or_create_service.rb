module Weapons
  class FindOrCreateService
    include ActiveModel::Validations
    validates :name, presence: true

    def initialize(name)
      @name = name
    end

    def call
      raise_validation_error if invalid?

      Weapon.find_or_create_by(
        name: name
      )
    end

    private

    attr_reader :name
  end
end
