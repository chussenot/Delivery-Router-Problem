def dat_file(type)
  name = "dat/#{type}.dat"
  File.open(name, 'w').tap do |f|
    f.write("# #{type}\n")
  end
end

namespace :bench do
  desc 'measure DeliveryRouter @solution update speed'
  task :measure do
    file_time = dat_file('time')
    customers = [
      Customer.new(id: 1, x: 1, y: 1),
      Customer.new(id: 2, x: 5, y: 1)
    ]
    restaurants = [
      Restaurant.new(id: 3, cooking_time: 15, x: 0, y: 0),
      Restaurant.new(id: 4, cooking_time: 35, x: 5, y: 5)
    ]
    riders = [
      Rider.new(id: 1, speed: 10, x: 2, y: 0),
      Rider.new(id: 2, speed: 10, x: 1, y: 0)
    ]
    delivery_router = DeliveryRouter.new(restaurants: restaurants,
                                         customers: customers, riders: riders)
    1000.times.each do |i|
      start = Time.now
      delivery_router.add_order(customer: 1, restaurant: 3)
      file_time.write("#{i}  #{Time.now - start}\n")
    end
    file_time.close unless file.nil?
  end
end
