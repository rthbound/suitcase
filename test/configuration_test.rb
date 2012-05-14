require "minitest_helper"

describe Suitcase do
  describe ".configure" do
    it "saves the configuration options passed in with the block in a Hash" do
      Suitcase.configure { |c| c.my_option = "something" }
      Suitcase.configuration[:my_option].must_equal("something")
    end
  end
end
