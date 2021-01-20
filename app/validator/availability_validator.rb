class AvailabilityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    shifts = Shift.where(studio: record.studio)
    date_ranges = shifts.map { |b| b.starting_at..(b.starting_at + b.duration.hours)}
    date_ranges.each do |range|
      if range.include? value
        record.errors.add(attribute, "not available")
      end
    end
  end
end
