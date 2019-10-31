require 'spec_helper'

require "movie"
require "rental"
require "customer"

describe "a customer" do
  let(:customer) { Customer.new "Martin" }
  let(:regular_movie) { Movie.new("Mad Max", RegularPrice.new) }
  let(:new_movie)  { Movie.new("The Hobbit", NewReleasePrice.new) }
  let(:childrens_movie) { Movie.new("Bambi", ChildrensPrice.new) }

  describe 'without any rentals' do
    it { expect(customer.statement).to eq "Rental record for Martin\nAmount owed is $0\nYou earned 0 frequent renter points" }
  end

  describe 'with one regular rental' do
    describe 'for 1 day' do
      before { customer.add_rental(Rental.new(regular_movie, 1)) }

      it { expect(customer.statement).to include 'Amount owed is $2' }
      it { expect(customer.statement).to include 'You earned 1 frequent renter points' }
    end

    describe 'for 2 days' do
      before { customer.add_rental(Rental.new(regular_movie, 2)) }

      it { expect(customer.statement).to include 'Amount owed is $2' }
      it { expect(customer.statement).to include 'You earned 1 frequent renter points' }
    end

    describe 'for 3 days' do
      before { customer.add_rental(Rental.new(regular_movie, 3)) }

      it { expect(customer.statement).to include 'Amount owed is $3.5' }
      it { expect(customer.statement).to include 'You earned 1 frequent renter points' }
    end
  end

  describe 'with one new release rental' do
    describe 'for 1 day' do
      before { customer.add_rental(Rental.new(new_movie, 1)) }

      it { expect(customer.statement).to include 'Amount owed is $3' }
      it { expect(customer.statement).to include 'You earned 1 frequent renter points' }
    end

    describe 'for 2 days' do
      before { customer.add_rental(Rental.new(new_movie, 2)) }

      it { expect(customer.statement).to include 'Amount owed is $6' }
      it { expect(customer.statement).to include 'You earned 2 frequent renter points' }
    end

    describe 'for 3 days' do
      before { customer.add_rental(Rental.new(new_movie, 3)) }

      it { expect(customer.statement).to include 'Amount owed is $9' }
      it { expect(customer.statement).to include 'You earned 2 frequent renter points' }
    end

  end

  describe "with one children's rental" do
    describe 'for 1 day' do
      before { customer.add_rental(Rental.new(childrens_movie, 1)) }

      it { expect(customer.statement).to include 'Amount owed is $1.5' }
      it { expect(customer.statement).to include 'You earned 1 frequent renter points' }
    end

    describe 'for 3 days' do
      before { customer.add_rental(Rental.new(childrens_movie, 3)) }

      it { expect(customer.statement).to include 'Amount owed is $1.5' }
      it { expect(customer.statement).to include 'You earned 1 frequent renter points' }
    end

    describe 'for 4 days' do
      before { customer.add_rental(Rental.new(childrens_movie, 4)) }

      it { expect(customer.statement).to include 'Amount owed is $3' }
      it { expect(customer.statement).to include 'You earned 1 frequent renter points' }
    end
  end

  context 'html statement' do
    let(:earned) do
      [
        "On this rental you earned <em>",
        "#{earnings}</em> frequent renter points"
      ].join
    end

    let(:owed) do
      "<p>You owe <em>#{owing}</em><p>"
    end

    describe 'without any rentals' do
      let(:statement) do
        [
          '<h1>Rentals for <em>',
          "Martin</em></h1><p>\n<p>",
          'You owe <em>0</em>',
          "<p>\nOn this rental you earned <em>",
          '0</em> frequent renter points<p>'
        ].join
      end
      it { expect(customer.html_statement).to eq statement }
    end
  
    describe 'with one regular rental' do
      describe 'for 1 day' do
        before { customer.add_rental(Rental.new(regular_movie, 1)) }

        let(:earnings) { 1 }
        let(:owing) { 2 }

        it { expect(customer.html_statement).to include owed }
        it { expect(customer.html_statement).to include earned }
      end
  
      describe 'for 2 days' do
        before { customer.add_rental(Rental.new(regular_movie, 2)) }
        let(:earnings) { 1 }
        let(:owing) { 2 }
        it { expect(customer.html_statement).to include owed }
        it { expect(customer.html_statement).to include earned }
      end
  
      describe 'for 3 days' do
        before { customer.add_rental(Rental.new(regular_movie, 3)) }
        let(:earnings) { 1 }
        let(:owing) { 3.5 }
        it { expect(customer.html_statement).to include owed }
        it { expect(customer.html_statement).to include earned }
      end
    end
  
    describe 'with one new release rental' do
      describe 'for 1 day' do
        before { customer.add_rental(Rental.new(new_movie, 1)) }
        let(:earnings) { 1 }
        let(:owing) { 3 }
        it { expect(customer.html_statement).to include owed }
        it { expect(customer.html_statement).to include earned }
      end
  
      describe 'for 2 days' do
        before { customer.add_rental(Rental.new(new_movie, 2)) }
        let(:earnings) { 2 }
        let(:owing) { 6 }
        
        it { expect(customer.html_statement).to include owed }
        it { expect(customer.html_statement).to include earned }
      end
  
      describe 'for 3 days' do
        before { customer.add_rental(Rental.new(new_movie, 3)) }
        let(:earnings) { 2 }
        let(:owing) { 9 }

        it { expect(customer.html_statement).to include owed }
        it { expect(customer.html_statement).to include earned }
      end
  
    end
  
    describe "with one children's rental" do
      describe 'for 1 day' do
        before { customer.add_rental(Rental.new(childrens_movie, 1)) }
        let(:earnings) { 1 }
        let(:owing) { 1.5 }
        it { expect(customer.html_statement).to include owed }
        it { expect(customer.html_statement).to include earned }
      end
  
      describe 'for 3 days' do
        before { customer.add_rental(Rental.new(childrens_movie, 3)) }
        let(:earnings) { 1 }
        let(:owing) { 1.5 }
        it { expect(customer.html_statement).to include owed }
        it { expect(customer.html_statement).to include earned }
      end
  
      describe 'for 4 days' do
        before { customer.add_rental(Rental.new(childrens_movie, 4)) }
          let(:earnings) { 1 }
          let(:owing) { 3.0 }
        it { expect(customer.html_statement).to include owed }
        it { expect(customer.html_statement).to include earned }
      end
    end
  end
end