$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe Daterange do
  describe "Initialization" do
    it "takes a start time and an end time" do
      Daterange.new(Object.new, Object.new).must_be_instance_of Daterange
    end

    it "Raises an error if wrong number of parameters are passed" do
      proc { Daterange.new(Object.new) }.must_raise ArgumentError
    end
  end

  describe "#each" do
    it "calls the block for each day in the timeframe" do
      daterange = Daterange.new(Time.parse("20130801"), Time.parse("20130805"))
      proc { daterange.each { puts "x" } }.must_output "x\n" * 5
    end
  end

  describe "#[]" do
    it "returns the date at the index provided" do
      start_time = Time.parse("20130801")
      end_time = Time.parse("20130805")
      daterange = Daterange.new(start_time, end_time)
      daterange[0].must_equal start_time
      daterange[1].must_equal (start_time + 60 * 60 * 24)
    end

    it "returns nil if nothing is found" do
      start_time = Time.parse("20130801")
      end_time = Time.parse("20130805")
      daterange = Daterange.new(start_time, end_time)
      daterange[10].must_be_nil
    end
  end
end
