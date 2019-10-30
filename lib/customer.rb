class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(rental)
    @rentals << rental
  end

  def statement
    total_amount, frequent_renter_points = 0, 0
    result = "Rental record for #{@name}\n"
    @rentals.each do |rental|
      # add frequent renter points
      frequent_renter_points += 1
      # add bonus points for a 2 day new release rental
      if rental.movie.price_code == Movie::NEW_RELEASE && rental.days_rented > 1
        frequent_renter_points += 1
      end

      result += "\t#{rental.movie.title}\t#{rental.charge}\n"
      total_amount += rental.charge
    end

    result += "Amount owed is $#{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result
  end
end