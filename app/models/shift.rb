# frozen_string_literal: true

class Shift < ApplicationRecord
  enum studio: %i[1 2 3]
  validates :studio, :starting_at, :duration, presence: true
  validates :starting_at, :duration, availability: true
end
