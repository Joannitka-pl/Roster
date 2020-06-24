class ShiftDecorator < Draper::Decorator
  delegate_all

  def studios_list
    Shift.studios.keys.map {|studio| [studio.titleize,studio]}
  end

  def hours_list
    Shift.hours.keys.map {|time| [time.titleize, time]} 
  end

end