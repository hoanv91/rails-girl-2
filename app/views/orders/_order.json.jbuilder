json.extract! order, :id, :first_name, :last_name, :state, :address, :city, :postcode, :phone, :email, :payment_method, :cart_id, :total, :created_at, :updated_at
json.url order_url(order, format: :json)
