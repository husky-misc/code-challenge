class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.filter(params)
    results = self.where(nil)
    params.each do |key, value|
      results = results.public_send(key, value) if value.present?
    end
    results
  end
end
