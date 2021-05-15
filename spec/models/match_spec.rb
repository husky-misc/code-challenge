require 'rails_helper'

RSpec.describe Match, type: :model do
  context 'when defining the model' do
    it { is_expected.to belong_to(:ranking) }

    it { is_expected.to have_many(:players) }

    it { is_expected.to validate_presence_of :ranking }
    it { is_expected.to validate_presence_of :started_at }
    it { is_expected.to validate_presence_of :ended_at }
    it { is_expected.to validate_presence_of :content }
  end

  context 'when validating the started_at and ended_at' do
    subject(:match) { build(:match) }

    it 'must return truthy if started_at is greater than ended_at' do
      expect(match.save!).to be_truthy
    end

    it 'must raise an error if started_at is greater than ended_at' do
      match.started_at = '2021-05-15 10:30'

      expect { match.save! }.to raise_error(ActiveRecord::RecordInvalid)
        .with_message('A validação falhou: Data Início não deve ser maior que Data Fim')
    end
  end
end
