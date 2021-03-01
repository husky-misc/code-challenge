game = Game.new
game.file.attach(io: File.open("#{Rails.root}/spec/files/log.txt"), filename: 'log')
game.save
