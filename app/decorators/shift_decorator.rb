class ShiftDecorator < Draper::Decorator
  delegate_all

  def studios_list
    Shift.studios.keys.map { |studio| [studio.titleize, studio] }
  end
  
end
