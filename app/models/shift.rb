# frozen_string_literal: true

class Shift < ApplicationRecord
  enum studio: %i[1 2 3]
  enum hour: %i[6-15 15-1 1-6]
end
