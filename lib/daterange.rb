class Daterange
  include Enumerable

  attr_accessor :start_time, :end_time

  ONEDAY = 24 * 60 * 60 

  def initialize(start_time, end_time)
    @start_time = start_time
    @end_time = end_time
  end

  def each
    @current_time = @start_time
    while @current_time <= @end_time
      yield @current_time
      @current_time += ONEDAY
    end
  end
end
