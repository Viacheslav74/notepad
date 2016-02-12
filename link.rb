class Link < Post # объявление дочернего класса Link. Post - родительский класс

  def initialize
    super # команда означает взять конструктор или метод из родительского класса

    @url = "" # ссылка
  end

  def read_from_console

  end

  def to_string

  end
end