require 'spec_helper'

#   This file is a simple Ruby RSpec test suite describing a DeliveryRouter class.
#   Your goals are to:
#   1) make those tests pass,
#   2) add tests for the edge cases.
#
#   If you need help to setup the project, see: https://gist.github.com/gaeldelalleau/f486f9e5fdcece8eb36e70f23c806184
#
#   Feel free to ask us any question!
#
#   Happy hacking :)
#
#   --
#
#   Goal: delight your customers by sending riders to pick and deliver their orders
#   in less than 60 minutes (faster if you can).
#
#   Hypothesis:
#     - (x, y) coordinates are used to locate restaurants, customers and riders on a grid
#     - the distance between x=0 and x=1 is 1000 meters (1 km)
#     - the distance between two arbitrary (x,y) locations is the euclidian distance (straight line)
#     - times are expressed in minutes
#     - speeds are expressed in kilometers per hour (km/h)
#
#   Note: some other hypothesis you can make to simplify the problem:
#     - all customer orders are received at the same time (t=0)
#     - all restaurants start cooking at the same time (t=0)
#     - all riders start moving at the same time (t=0)
#     - each restaurant can cook an infinite number of meals in parallel
#     - each rider can carry an infinite amount of meals at the same time
#     - riders are ninjas! They fly over trafic jams and buildings, they never need to take
#       a break and they know how to solve a NP-complete problem in polynomial time ;)

describe DeliveryRouter do
  describe 'Configuration' do
    before(:all) do
      DeliveryRouter.configure do |config|
        config.steps = [SimpleOperation, SimpleOperation]
      end
    end

    it 'can be reset' do
      expect(DeliveryRouter.config.steps).to match_array([SimpleOperation, SimpleOperation])
      DeliveryRouter.reset
      expect(DeliveryRouter.config.steps).to match_array([])
    end
  end

  describe 'np#route' do
    before(:all) do
      DeliveryRouter.configure do |config|
        config.steps = [
          Np::EvaluateSolutions,
          Np::DetermineMatchings
        ]
      end
        @customers = [
          Customer.new(id: 1, x: 1, y: 1),
          Customer.new(id: 2, x: 5, y: 1),
          Customer.new(id: 3, x: 3, y: 8),
          Customer.new(id: 4, x: 7, y: 22)
        ]
        @restaurants = [
          Restaurant.new(id: 1, cooking_time: 15, x: 0, y: 0),
          Restaurant.new(id: 2, cooking_time: 5, x: 5, y: 5),
          Restaurant.new(id: 3, cooking_time: 25, x: 2, y: 10),
          Restaurant.new(id: 4, cooking_time: 35, x: 8, y: 15)
        ]
        @riders = [
          Rider.new(id: 1, speed: 10, x: 2, y: 0),
          Rider.new(id: 2, speed: 10, x: 1, y: 0),
          Rider.new(id: 2, speed: 7, x: 10, y: 0),
          Rider.new(id: 2, speed: 10, x: 5, y: 3)
        ]
        @delivery_router = DeliveryRouter.new(restaurants: @restaurants,
                                              customers: @customers, riders: @riders)
    end

    context 'Add orders to sequential manner' do
      before(:all) do
        @delivery_router.add_order(customer: 1, restaurant: 3)
        @delivery_router.add_order(customer: 2, restaurant: 4)
        @delivery_router.add_order(customer: 3, restaurant: 4)
        @delivery_router.add_order(customer: 4, restaurant: 1)
      end
      it 'do something' do
        # binding.pry
      end
    end

  end

  describe '#route' do
    before(:all) do
      DeliveryRouter.configure do |config|
        config.steps = [
          Naive::CalculateRideTimesToRestaurant,
          Naive::MatchRidersWithOrders,
          Naive::CalculateTotalJourneyTimes
        ]
      end
      @customers = [
        Customer.new(id: 1, x: 1, y: 1),
        Customer.new(id: 2, x: 5, y: 1)
      ]
      @restaurants = [
        Restaurant.new(id: 3, cooking_time: 15, x: 0, y: 0),
        Restaurant.new(id: 4, cooking_time: 35, x: 5, y: 5)
      ]
      @riders = [
        Rider.new(id: 1, speed: 10, x: 2, y: 0),
        Rider.new(id: 2, speed: 10, x: 1, y: 0)
      ]
      @delivery_router = DeliveryRouter.new(restaurants: @restaurants,
                                            customers: @customers, riders: @riders)
    end

    context 'given customer 1 orders from restaurant 3' do
      before(:all) do
        @delivery_router.add_order(customer: 1, restaurant: 3)
      end

      context 'given customer 2 does not order anything' do
        before(:all) do
          @delivery_router.clear_orders(customer: 2)
        end

        it 'does not assign a route to rider 1' do
          route = @delivery_router.route(rider: 1)
          expect(route).to be_empty
        end

        it 'sends rider 2 to customer 1 through restaurant 3' do
          route = @delivery_router.route(rider: 2)
          expect(route.length).to eq(2)
          expect(route[0].id).to eq(3)
          expect(route[1].id).to eq(1)
        end

        it 'delights customer 1' do
          expect(@delivery_router.delivery_time(customer: 1)).to be < 60
        end
      end

      context 'given customer 2 orders from restaurant 4' do
        before(:all) do
          @delivery_router.add_order(customer: 2, restaurant: 4)
        end

        it 'sends rider 1 to customer 2 through restaurant 4' do
          route = @delivery_router.route(rider: 1)
          expect(route.length).to eq(2)
          expect(route[0].id).to eq(4)
          expect(route[1].id).to eq(2)
        end

        it 'sends rider 2 to customer 1 through restaurant 3' do
          route = @delivery_router.route(rider: 2)
          expect(route.length).to eq(2)
          expect(route[0].id).to eq(3)
          expect(route[1].id).to eq(1)
        end

        it 'delights customer 1' do
          expect(@delivery_router.delivery_time(customer: 1)).to be < 60
        end

        it 'delights customer 2' do
          expect(@delivery_router.delivery_time(customer: 2)).to be < 60
        end
      end
    end
  end
end
