module Players
  class FindOrCreateService
    include ActiveModel::Validations
    validates :nickname, presence: true

    def initialize(nickname)
      @nickname = nickname
    end

    def call
      raise_validation_error if invalid?

      Player.find_or_create_by(
        nickname: nickname
      )
    end

    private

    attr_reader :nickname
  end
end
