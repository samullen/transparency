class Daterange
  include Enumerable

  attr_accessor :start_time, :end_time

  ONEDAY = 24 * 60 * 60 

  def initialize(start_time, end_time)
    @start_time = start_time
    @end_time = end_time
  end

  def each
    current_time = self.start_time
    while current_time <= self.end_time
      yield current_time
      current_time += ONEDAY
    end
  end

  def [](index)
    index *= ONEDAY

    if self.start_time + index <= self.end_time
      self.start_time + index
    end
  end
end
