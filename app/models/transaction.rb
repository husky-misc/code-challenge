# frozen_string_literal: true

class Transaction < ApplicationRecord
  CREDIT = 'credit'
  DEBIT  = 'debit'
  TYPES  = [CREDIT, DEBIT]

  belongs_to :account

  validates :operation_type, inclusion: { in: TYPES, message: 'Operation type must be credit or debit' }
  validates :value, numericality: { greater_than_or_equal_to: 0 }, if: :credit?
  validates :value, numericality: { less_than_or_equal_to: 0 },    if: :debit?

  scope :filter_days,  ->(days) { where(created_at: days.days.ago.beginning_of_day..DateTime::Infinity.new) }
  scope :past_balance, ->(days) { where('created_at < ?', days.days.ago.beginning_of_day).sum(:value) }

  def initialize(*)
    super
    negative_debit_transaction
  end

  def display_value
    value.abs
  end

  def credit?
    operation_type == CREDIT
  end

  def debit?
    !credit?
  end

  private

  def negative_debit_transaction
    self.value *= -1 if debit?
  end
end
