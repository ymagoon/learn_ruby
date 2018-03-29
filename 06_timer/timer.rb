class Timer
  def initialize
    @seconds = 0
  end

  def seconds=(value)
    @seconds = value
  end

  def seconds
    @seconds
  end

  def time_string
    @hours = formatter(@seconds / 3600)
    @seconds = @seconds % 3600
    @minutes = formatter(@seconds / 60)
    @seconds = formatter(@seconds % 60)

    "#{@hours}:#{@minutes}:#{@seconds}"
  end

  private
  def formatter(time)
    return time.to_s.rjust(2,'0')
  end
end
