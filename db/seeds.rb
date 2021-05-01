file = File.new(File.join(Rails.root, "test", "fixtures", "files", "matches"))

Match::FileImporter.new(file: file).import
