require_relative '../src/regular_price'
require_relative '../src/new_release_price'
require_relative '../src/childrens_price'

class Movie
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2
  attr_reader :title
  attr_reader :price_code

  def initialize(title, the_price_code)
    @title, self.price_code = title, the_price_code
  end

  def price_code=(value)
    @price_code=value
    @price = case price_code
               when REGULAR
                 RegularPrice.new
               when NEW_RELEASE
                 NewReleasePrice.new
               when CHILDRENS
                 ChildrensPrice.new
             end
  end

  def charge(days_rented)
    @price.charge(days_rented)
  end

  def frequent_renter_points(days_rented)
    price_code == NEW_RELEASE && days_rented > 1 ? 2 : 1
  end
end