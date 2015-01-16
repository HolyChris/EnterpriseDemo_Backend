require 'time'

class Time
  def hour_format
    self.hour * 100 + self.min 
  end
end