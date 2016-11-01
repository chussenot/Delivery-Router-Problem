Bundler.require :default
require 'facets/hash/symbolize_keys'
require 'uber/builder'

# Additions to String class
class String
  def camelize
    split(/[^a-z0-9]/i).map(&:capitalize).join
  end

  def classify
    split('/').map(&:camelize).join('::')
  end
end

# require classes
def require_all(root, pattern)
  Dir[File.join(root, pattern)].tap do |files|
    files.each do |file|
      autoload(File.basename(file, '.rb').classify.to_sym, file)
    end
    files.each { |file| require(file) }
  end
end

require_all '.', '{lib}/**/*.rb'

DeliveryRouter.configure do |config|
  config.steps = [
    CalculateRideTimesToRestaurant,
    MatchRidersWithOrders,
    CalculateTotalJourneyTimes
  ]
end
