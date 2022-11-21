require 'rails_helper'

RSpec.describe User, type: :model do
  before(:example) { @user = User.new }

  it "is not valid without an email" do
    expect(@user).to_not be_valid
  end

  it "is not valid without a password" do
    expect(@user).to_not be_valid
  end

  it "is not valid without a rol" do
    expect(@user).to_not be_valid
  end
end
