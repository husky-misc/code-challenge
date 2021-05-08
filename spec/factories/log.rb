FactoryBot.define do
  factory :log, class: '::Log' do
    game_mode { ::Log::GAME_MODES.sample }
    sequence(:description) { |n| "description_#{n}" }
    file { Rack::Test::UploadedFile.new('spec/fixtures/files/matches_log.txt', 'text/plain') }
    is_valid { true }
  end

  factory :invalid_log, class: '::Log' do
    game_mode { ::Log::GAME_MODES.sample }
    sequence(:description) { |n| "description_#{n}" }
    file do
      Rack::Test::UploadedFile.new('spec/fixtures/files/matches/invalid_match_content.txt',
                                   'text/plain')
    end
  end
end
