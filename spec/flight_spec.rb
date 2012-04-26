require "spec_helper"

describe Suitcase::Flight do
  describe ".find" do
    it "returns an Array of Flight's" do
      flights = Suitcase::Flight.find(from: "Boston", to: "Los Angeles", departure_date: "2012/07/14")
      flights.should be_a Array
      flights.first.should be_a Flight
    end
  end
end