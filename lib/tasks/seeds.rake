task :seeds => :environment do
  ApiKey.create!(token: 'ed62fc4bc51f2ab94b59c15f6c9f63896dce60dc')
end