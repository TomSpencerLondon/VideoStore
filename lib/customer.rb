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
    frequent_renter_points = 0
    result = "Rental record for #{@name}\n"
    @rentals.each do |rental|
      result += "\t#{rental.movie.title}\t#{rental.charge}\n"
    end

    result += "Amount owed is $#{total_charge}\n"
    result += "You earned #{total_frequent_renter_points} frequent renter points"
    result
  end

  def html_statement
    result = "<h1>Rentals for <em>#{@name}</em></h1><p>\n"
    @rentals.each do |rental|
      # show figures for this rental
      result += "\t" + rental.movie.title + ": " + rental.charge.to_s + "<br>\n"
    end
    # add footer lines
    result += "<p>You owe <em>#{total_charge}</em><p>\n"
    result += "On this rental you earned " +
           "<em>#{total_frequent_renter_points}</em> " +
           "frequent renter points<p>"
    result
  end

  private

  def total_charge
    @rentals.inject(0) { |sum, rental| sum + rental.charge }
  end

  def total_frequent_renter_points
    @rentals.inject(0){ |sum, rental| sum + rental.frequent_renter_points }
  end
end