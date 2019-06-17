class HomeController < ApplicationController
  # http_basic_authenticate_with name: "dhh", password: "secret", only: :index
  def index
    @products = Product.first(4)
  end
end