require 'rake'
require 'caching'
require_relative '../../app/models/application_record'

Dir[File.join(__dir__, '..', '..', 'app', '**', '*.rb')].each { |file| require file }

def find_cached_classes
  ObjectSpace.each_object(Class).select { |klass| klass.included_modules.include?(Caching::CacheableResource) }
end

namespace :caching do
  desc 'Warm all configured caches'
  task warm: :environment do
    find_cached_classes.each { |klass| klass.warm_cache! }
  end
end
