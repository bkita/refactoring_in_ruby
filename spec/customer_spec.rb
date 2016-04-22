require 'spec_helper'
require_relative '../src/customer'
require_relative '../src/movie'
require_relative '../src/rental'

describe 'Customer' do

  let(:customer) { Customer.new('Bartosz') }
  let(:regular_movie) { Movie.new('Regular movie', Movie::REGULAR) }
  let(:new_release_movie) { Movie.new('New release movie', Movie::NEW_RELEASE) }
  let(:childrens_movie) { Movie.new('Childrens movie', Movie::CHILDRENS) }
  let(:rental) { Movie.new('Childrens movie', Movie::CHILDRENS) }

  it 'should have one regular movie' do
    customer.add_rental(rental(regular_movie, 1))
    expect(customer.statement).to include 'Regular movie	2'
  end

  it 'should have amount owned equals 2' do
    customer.add_rental(rental(regular_movie, 1))
    expect(customer.statement).to include 'Amount owed is 2'
  end

  private

  def rental(movie, days)
    Rental.new(movie, days)
  end
end