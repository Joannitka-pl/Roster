# frozen_string_literal: true

class Shift < ApplicationRecord
  enum studio: %i[1 2 3]
  enum hour: %i[6-15 15-1 1-6]
  validates :studio, :date, :hour, presence: true
  validates_uniqueness_of :studio, scope: %i[hour date]
end
