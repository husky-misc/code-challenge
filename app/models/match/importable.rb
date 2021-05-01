module Match::Importable
  extend ActiveSupport::Concern

  class_methods do
    def import(file:)
      Match::FileImporter.new(file: file).import
    end
  end
end
