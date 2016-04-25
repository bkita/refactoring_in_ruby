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

  describe 'Rents one movie for one day' do
    number_of_days = 1

    describe 'Regular movie' do
      it 'should have one regular movie' do
        customer.add_rental(rental(regular_movie, number_of_days))
        expect(customer.statement).to include regular_movie_statement 2
      end

      it 'should show amount owned is 2' do
        customer.add_rental(rental(regular_movie, number_of_days))
        expect(customer.statement).to include amount_owed 2
      end

      it 'should show 1 earned frequent points' do
        customer.add_rental(rental(regular_movie, number_of_days))
        expect(customer.statement).to include renter_points 1
      end
    end

    describe 'New release movie' do
      it 'should have one new release movie' do
        customer.add_rental(rental(new_release_movie, number_of_days))
        expect(customer.statement).to include new_release_movie_statement 3
      end

      it 'should show amount owned is 3' do
        customer.add_rental(rental(new_release_movie, number_of_days))
        expect(customer.statement).to include amount_owed 3
      end

      it 'should show 1 earned frequent points' do
        customer.add_rental(rental(new_release_movie, number_of_days))
        expect(customer.statement).to include renter_points 1
      end
    end

    describe 'Childrens movie' do
      it 'should have one childrens movie' do
        customer.add_rental(rental(childrens_movie, number_of_days))
        expect(customer.statement).to include childrens_movie_statement 1.5
      end

      it 'should show amount owned is 3' do
        customer.add_rental(rental(childrens_movie, number_of_days))
        expect(customer.statement).to include amount_owed 1.5
      end

      it 'should show 1 earned frequent points' do
        customer.add_rental(rental(childrens_movie, number_of_days))
        expect(customer.statement).to include renter_points 1
      end
    end
  end

  describe 'Rents one movie for five days' do
    number_of_days = 5

    describe 'Regular movie' do
      it 'should have one regular movie' do
        customer.add_rental(rental(regular_movie, number_of_days))
        expect(customer.statement).to include regular_movie_statement 6.5
      end

      it 'should show amount owned is 6.5' do
        customer.add_rental(rental(regular_movie, number_of_days))
        expect(customer.statement).to include amount_owed 6.5
      end

      it 'should show 1 earned frequent points' do
        customer.add_rental(rental(regular_movie, number_of_days))
        expect(customer.statement).to include renter_points 1
      end
    end

    describe 'New release movie' do
      it 'should have one new release movie' do
        customer.add_rental(rental(new_release_movie, number_of_days))
        expect(customer.statement).to include new_release_movie_statement 15
      end

      it 'should show amount owned is 15' do
        customer.add_rental(rental(new_release_movie, number_of_days))
        expect(customer.statement).to include amount_owed 15
      end

      it 'should show 2 (+1 bonus for a two day new release rental) earned frequent points' do
        customer.add_rental(rental(new_release_movie, number_of_days))
        expect(customer.statement).to include renter_points 2
      end
    end

    describe 'Childrens movie' do
      it 'should have one childrens movie' do
        customer.add_rental(rental(childrens_movie, number_of_days))
        expect(customer.statement).to include childrens_movie_statement 4.5
      end

      it 'should show amount owned is 4.5' do
        customer.add_rental(rental(childrens_movie, number_of_days))
        expect(customer.statement).to include amount_owed 4.5
      end

      it 'should show 1 earned frequent points' do
        customer.add_rental(rental(childrens_movie, number_of_days))
        expect(customer.statement).to include renter_points 1
      end
    end
  end

  describe 'Rents many movies for many days' do
    before(:each) do
      customer.add_rental(rental(regular_movie, 1))
      customer.add_rental(rental(regular_movie, 3))
      customer.add_rental(rental(regular_movie, 15))

      customer.add_rental(rental(new_release_movie, 1))
      customer.add_rental(rental(new_release_movie, 3))
      customer.add_rental(rental(new_release_movie, 15))

      customer.add_rental(rental(childrens_movie, 1))
      customer.add_rental(rental(childrens_movie, 3))
      customer.add_rental(rental(childrens_movie, 15))
    end

    it 'should show correct statement and price for regular movies' do
      expect(customer.statement).to include regular_movie_statement 2
      expect(customer.statement).to include regular_movie_statement 3.5
      expect(customer.statement).to include regular_movie_statement 21.5
    end

    it 'should show correct statement and price for new release movies' do
      expect(customer.statement).to include new_release_movie_statement 3
      expect(customer.statement).to include new_release_movie_statement 9
      expect(customer.statement).to include new_release_movie_statement 45
    end

    it 'should show correct statement and price for childres movies' do
      expect(customer.statement).to include childrens_movie_statement 1.5
      expect(customer.statement).to include childrens_movie_statement 19.5
    end

    it 'should show correct amount owed' do
      expect(customer.statement).to include amount_owed 106.5
    end

    it 'should show correct number of renter points' do
      expect(customer.statement).to include renter_points 11
    end
  end

  private

  def rental(movie, days)
    Rental.new(movie, days)
  end

  def regular_movie_statement(price)
    'Regular movie	price'.gsub! 'price', price.to_s
  end

  def new_release_movie_statement(price)
    'New release movie	price'.gsub! 'price', price.to_s
  end

  def childrens_movie_statement(price)
    'Childrens movie	price'.gsub! 'price', price.to_s
  end

  def amount_owed(price)
    'Amount owed is price'.gsub! 'price', price.to_s
  end

  def renter_points(points)
    'You earned number_of_points frequent renter points'.gsub! 'number_of_points', points.to_s
  end

end