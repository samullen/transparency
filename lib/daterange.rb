class Daterange
  include Enumerable

  attr_accessor :start_date, :end_date

  ONEDAY = 1

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def each
    current_date = self.start_date
    while current_date <= self.end_date
      yield current_date
      current_date += ONEDAY
    end
  end

  def [](index)
    index *= ONEDAY

    if self.start_date + index <= self.end_date
      self.start_date + index
    end
  end
end
