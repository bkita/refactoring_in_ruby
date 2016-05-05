class Movie
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2
  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price_code)
    @title, @price_code = title, price_code
  end

  def charge(days_rented)
    this_amount = 0
    case price_code
      when REGULAR
        this_amount += 2
        this_amount += (days_rented - 2) * 1.5 if days_rented > 2
      when NEW_RELEASE
        this_amount += days_rented * 3
      when CHILDRENS
        this_amount += 1.5
        this_amount += (days_rented - 3) * 1.5 if days_rented > 3
    end
    this_amount
  end

  def frequent_renter_points(days_rented)
    frequent_renter_points = 1
    # add bonus for a two day new release rental
    if price_code == NEW_RELEASE && days_rented > 1
      frequent_renter_points += 1
    end
    frequent_renter_points
  end
end