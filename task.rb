class Task < Post
  def initialize
    super

    @due_date = Time.now # сделаем по умолчанию текущее время
  end

  def read_from_console

  end

  def to_string

  end
end