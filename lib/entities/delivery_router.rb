class DeliveryRouter < Struct.new(:id, :x, :y)
  def add_order(*args)
  end

  def route(*_args)
    []
  end

  def delivery_time(*_args)
    1
  end

  def clear_orders(*args)
  end
end
