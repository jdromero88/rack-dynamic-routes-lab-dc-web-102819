class Application
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      item_name = req.path.split("/items/").last
      item_price = Item.find_by(item_name)
      if item_price.nil?
        resp.status = 400
        resp.write "Item not found"
      else
        resp.write item_price
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
