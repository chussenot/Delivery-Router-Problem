Bundler.require :default
require 'facets/hash/symbolize_keys'

class String
  def camelize
    split(/[^a-z0-9]/i).map(&:capitalize).join
  end

  def classify
    split('/').map(&:camelize).join('::')
  end
end

# Autoload classes
def autoload_all(root, pattern)
  Dir[File.join(root, pattern)].tap do |files|
    files.each do |file|
      autoload(File.basename(file, '.rb').classify.to_sym, file)
    end
    files.each { |file| require(file) }
  end
end

autoload_all '.', '{lib}/**/*.rb'

DeliveryRouter.configure do |config|
  config.steps = [
    TimeToRestaurant,
    BestRider,
    RideTotalDuration
  ]
end
