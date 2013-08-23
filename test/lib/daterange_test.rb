$LOAD_PATH.unshift(File.expand_path("../..", __FILE__))
require "test_helper"

describe Timeframe do
  describe "Initialization" do
    it "takes a start time and an end time" do
      Timeframe.new(Object.new, Object.new).must_be_instance_of Timeframe
    end

    it "Raises an error if wrong number of parameters are passed" do
      proc { Timeframe.new(Object.new) }.must_raise ArgumentError
    end
  end

  describe "#each" do
    it "calls the block for each day in the timeframe" do
      timeframe = Timeframe.new(Time.parse("20130801"), Time.parse("20130805"))
      proc { timeframe.each { puts "x" } }.must_output "x\n" * 5
    end
  end

end
