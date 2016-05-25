require_relative '../src/regular_price'
require_relative '../src/new_release_price'
require_relative '../src/childrens_price'

class Movie
  attr_reader :title
  attr_reader :price

  def initialize(title, price)
    @title, @price = title, price
  end

  def charge(days_rented)
    @price.charge(days_rented)
  end

  def frequent_renter_points(days_rented)
    @price.frequent_renter_points(days_rented)
  end
end