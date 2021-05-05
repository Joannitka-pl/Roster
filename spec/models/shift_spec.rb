require 'rails_helper'

describe Shift do

  it 'has a valid factory' do
    expect(build(:shift)).to be_valid
  end

  it 'is invalid without a studio' do
    shift = build(:shift, studio: nil)
    shift.valid?
    expect(shift.errors[:studio]).to include("can't be blank")
  end

  it 'is invalid without a starting_at' do
    shift = build(:shift, starting_at: nil)
    shift.valid?
    expect(shift.errors[:starting_at]).to include("can't be blank")
  end

  it 'is invalid without a duration' do
    shift = build(:shift, duration: nil)
    shift.valid?
    expect(shift.errors[:duration]).to include("can't be blank")
  end

  it 'has a valid factory' do
    create(:shift, starting_at: Time.now, duration: "8")
    shift = build(:shift, starting_at: Time.now + 2.hours, duration: "4")
    shift.valid?
    expect(shift.errors[:starting_at]).to include('not available')
  end

end