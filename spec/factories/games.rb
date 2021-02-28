# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    file { fixture_file_upload("#{Rails.root}/spec/files/log.txt", 'text/plain') }
  end
end
