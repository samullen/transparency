class Timeframe
  include Enumerable

  attr_accessor :start_time, :end_time

  ONEDAY = 24 * 60 * 60 

  def initialize(start_time, end_time)
    @start_time = start_time
    @end_time = end_time
    @current_time = @start_time
  end

  def each
    while @current_time <= @end_time
      @current_time += ONEDAY
      yield @current_time
    end
  end
end
