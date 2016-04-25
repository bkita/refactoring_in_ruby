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
        expect(customer.statement).to include 'Regular movie	2'
      end

      it 'should show amount owned is 2' do
        customer.add_rental(rental(regular_movie, number_of_days))
        expect(customer.statement).to include 'Amount owed is 2'
      end

      it 'should show 1 earned frequent points' do
        customer.add_rental(rental(regular_movie, number_of_days))
        expect(customer.statement).to include 'You earned 1 frequent renter points'
      end
    end

    describe 'New release movie' do
      it 'should have one new release movie' do
        customer.add_rental(rental(new_release_movie, number_of_days))
        expect(customer.statement).to include 'New release movie	3'
      end

      it 'should show amount owned is 3' do
        customer.add_rental(rental(new_release_movie, number_of_days))
        expect(customer.statement).to include 'Amount owed is 3'
      end

      it 'should show 1 earned frequent points' do
        customer.add_rental(rental(new_release_movie, number_of_days))
        expect(customer.statement).to include 'You earned 1 frequent renter points'
      end
    end

    describe 'Childrens movie' do
      it 'should have one childrens movie' do
        customer.add_rental(rental(childrens_movie, number_of_days))
        expect(customer.statement).to include 'Childrens movie	1.5'
      end

      it 'should show amount owned is 3' do
        customer.add_rental(rental(childrens_movie, number_of_days))
        expect(customer.statement).to include 'Amount owed is 1.5'
      end

      it 'should show 1 earned frequent points' do
        customer.add_rental(rental(childrens_movie, number_of_days))
        expect(customer.statement).to include 'You earned 1 frequent renter points'
      end
    end
  end

  describe 'Rents one movie for five days' do
    number_of_days = 5

    describe 'Regular movie' do
      it 'should have one regular movie' do
        customer.add_rental(rental(regular_movie, number_of_days))
        expect(customer.statement).to include 'Regular movie	6.5'
      end

      it 'should show amount owned is 6.5' do
        customer.add_rental(rental(regular_movie, number_of_days))
        expect(customer.statement).to include 'Amount owed is 6.5'
      end

      it 'should show 1 earned frequent points' do
        customer.add_rental(rental(regular_movie, number_of_days))
        expect(customer.statement).to include 'You earned 1 frequent renter points'
      end
    end

    describe 'New release movie' do
      it 'should have one new release movie' do
        customer.add_rental(rental(new_release_movie, number_of_days))
        expect(customer.statement).to include 'New release movie	15'
      end

      it 'should show amount owned is 15' do
        customer.add_rental(rental(new_release_movie, number_of_days))
        expect(customer.statement).to include 'Amount owed is 15'
      end

      it 'should show 2 (+1 bonus for a two day new release rental) earned frequent points' do
        customer.add_rental(rental(new_release_movie, number_of_days))
        expect(customer.statement).to include 'You earned 2 frequent renter points'
      end
    end

    describe 'Childrens movie' do
      it 'should have one childrens movie' do
        customer.add_rental(rental(childrens_movie, number_of_days))
        expect(customer.statement).to include 'Childrens movie	4.5'
      end

      it 'should show amount owned is 4.5' do
        customer.add_rental(rental(childrens_movie, number_of_days))
        expect(customer.statement).to include 'Amount owed is 4.5'
      end

      it 'should show 1 earned frequent points' do
        customer.add_rental(rental(childrens_movie, number_of_days))
        expect(customer.statement).to include 'You earned 1 frequent renter points'
      end
    end
  end

  private

  def rental(movie, days)
    Rental.new(movie, days)
  end
end