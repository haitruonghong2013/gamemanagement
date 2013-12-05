class Time
  def as_json(options = nil) #:nodoc:
    if ActiveSupport.use_standard_json_time_format
      strftime("%Y-%m-%d %H:%M:%S")
    else
      strftime("%Y-%m-%d %H:%M:%S")
    end
  end
end