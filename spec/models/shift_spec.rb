require 'rails_helper'

describe Shift do
  it "has a valid factory" do
    expect(FactoryBot.build(:shift)).to be_valid
  end

  it "is valid with a studio, hours, date and user_id" do
    shift = Shift.new(
      studio: "1",
      date: "3rd Jul 2020",
      hour: "1-6",
      user_id: "1")
    expect(shift).to be_valid
  end

  it "is invalid without a studio" do
    shift = build(:shift, studio: nil)
    shift.valid?
    expect(shift.errors[:studio]).to include('cannot be blank')
  end
  
  it "is invalid without hours" do
  shift = build(:shift, hour: nil)
  shift.valid?
  expect(shift.errors[:hour]).to include('cannot be blank')
end

  it "is invalid without a date" do
    shift = build(:shift, date: nil)
    shift.valid?
    expect(shift.errors[:date]).to include('cannot be blank')
  end

  it "is invalid without an user_id" do
    shift = build(:shift, user_id: nil)
    shift.valid?
    expect(shift.errors[:user_id]).to include('cannot be blank')
  end

  it "is invalid with a duplicate combination of a studio, hours and date" do
    shift_first = create(
      :shift,
      studio: "1",
      date: "3rd Jul 2020",
      hour: "1-6",
      user_id: "1")
    shift_second = build(
      :shift,
      studio: "1",
      date: "3rd Jul 2020",
      hour: "1-6",
      user_id: "2")
    shift_second.valid?
    match_attributes = shift_first.attributes.except(:user_id)
    expect(shift_second.errors[match_attributes]).to include('has already been created')
  end
end