class Round < ApplicationRecord
  belongs_to :match

  enum action: { kill: 'kill' }

  validates :metadata, :action, presence: true
  validates :action, inclusion: { in: actions.keys }

  before_save :validate_metadata

  def validate_metadata
    required_info =
      case action
      when "kill"
        ["killer_player_nickname", "dead_player_nickname"]
      else
        # This can be updated to accept new round actions in the future
        []
      end

    if (required_info - metadata.keys) != []
      errors.add(:metadata, :invalid, message: "does not have required info: #{required_info}")

      throw :abort
    end
  end
end
