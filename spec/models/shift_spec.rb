require 'rails_helper'

describe Shift do
  it "is valid with a studio, hours, date and user_id" do
    shift = Shift.new(
      studio: "1",
      date: "3rd Jul 2020",
      hour: "1-6"
      user_id: "1"
    )
    expect(shift).to be_valid
  end

  it "is invalid without a studio" do
    shift = Shift.new(studio: nil)
    shift.valid?
    expect(shift.errors[:studio]).to include('cannot be blank')
  end
  
  it "is invalid without hours"
  it "is invalid without a date"
  it "is invalid without an user_id"
  it "is invalid with a duplicate combination of a studio, hours and date"
  it "returns a shift full details as an array"
end