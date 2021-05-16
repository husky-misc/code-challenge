class Ranking < ApplicationRecord
  self.table_name = :rankings

  belongs_to :log, class_name: '::Log', inverse_of: :ranking

  has_many :matches, class_name: '::Match', inverse_of: :ranking, dependent: :destroy

  validates :log, presence: true

  state_machine :status, initial: :pending, namespace: :ranking do
    after_transition from: :pending, to: :validating, do: :call_validate_log_file_service

    after_transition from: :validating, to: :processing, do: :call_process_ranking_service

    after_transition from: :processing, to: :processed, do: :define_processed_ranking

    after_transition any => :rejected, do: :define_rejected_ranking

    event :transmit do
      transition pending: :validating
    end

    event :validate do
      transition validating: :processing, if: :validate_success?
      transition validating: :rejected
    end

    event :process do
      transition processing: :processed, if: :process_success?
      transition processing: :rejected
    end
  end

  def generate
    @log_file = log.file.open { |file| File.read(file) }

    transmit_ranking

    unless @validate_result[:success]
      return [false, @validate_result[:result], @validate_result[:errors]]
    end

    [@process_result[:success], @process_result[:result], @process_result[:errors]]
  end

  private

  def call_validate_log_file_service
    response =
      ::AppServices::Log::ValidateLogFileService.new(@log_file, log.game_mode).call

    @validate_result = handle_response(response)

    validate_ranking
  end

  def call_process_ranking_service
    response = ::AppServices::Ranking::ProccessRankingService.new.call(id, @log_file)

    @process_result = handle_response(response)

    process_ranking
  end

  def validate_success?
    @validate_result[:success]
  end

  def process_success?
    @process_result[:success]
  end

  def handle_response(response)
    errors = response[:errors]

    { success: errors.blank?, result: response[:result], errors: errors }
  end

  def define_processed_ranking
    log.update!(is_valid: true)
    self.processed_at = Time.zone.now
    save!
  end

  def define_rejected_ranking
    self.rejected_at = Time.zone.now
    save!
  end
end
