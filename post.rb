class Post
  def initialaze # конструктор класса
    @created_at = Time.now # сразу присвоим полю текущее значение времени
    @text = nil # присвоим полю nil потому что каждый класс-ребенок будет иметь
    # свое значение в этом поле
  end

  def read_from_console # метод запрашивает ввод записей пользователя

    #todo будет делать дочерний класс

  end

  def to_strings # должен возвращать содержимое объекта в виде массива строк
    #todo будет делать дочерний класс
  end

  def save # метод сохранения
    file = File.new(file_path, "w:UTF-8") # создали новый файл буд-то мы знаем где он
    #будет находиться. Содержимое этого файла в виде массива строк

    for item in to_strings do
      file.puts(item)
    end

    file.close

  end

  def file_path # определяет путь к файлу, куда записывать содержимое
    current_path = File.dirname(__FILE__) # путь к файлу в текущей папке проекта

    file_name = @created_at.strftime("#{self.class.name}_%Y-%m-%d_%H-%M-%S.txt")
    # преобразовываем к строке. Вначале запишем имя класса, чтобы отличать
    #  self.class.name. %Y-%m-%d_%H-%M-%S - дата создания и время
    # один файл - одна запись

    return  current_path + "/" + file_name
  end
end