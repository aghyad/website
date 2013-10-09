require "spec_helper"
require "zombie"

describe Zombie do
  it "is named Ash" do
    z = Zombie.new
    z.name.should == "Ash"
  end

  it "has no brains" do
    z = Zombie.new
    z.brains.should < 1
  end

  it "should be hungry" do
    z = Zombie.new
    # z.hungry?.should == true
    # z.hungry?.should be_true
    z.should be_hungry
  end
end
