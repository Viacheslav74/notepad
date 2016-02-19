# encoding: UTF-8
# Подключим встроенный в руби класс Date для работы с датами
require 'date'

class Task < Post
  def initialize
    super

    @due_date = Time.now # сделаем по умолчанию текущее время. Потом заменим на будущее
  end

  def read_from_console

  	# Мы полностью переопределяем метод read_from_console родителя Post

    # Спросим у пользователя, что за задачу ему нужно сделать
    # Одной строчки будет достаточно
    puts "Что вам необходимо сделать?"
    @text = STDIN.gets.chomp

    # А теперь спросим у пользователя, до какого числа ему нужно это сделать
    # И подскажем формат, в котором нужно вводить дату
    puts "До какого числа вам нужно это сделать?"
    puts "Укажите дату в формате ДД.ММ.ГГГГ, например 12.05.2003"
    input = STDIN.gets.chomp

    # Для того, чтобы записть дату в удобном формате, воспользуемся методом parse класса Time
    @due_date = Date.parse(input) # поле @due_date 
  end

  def to_strings
  	 time_string = "Создано: #{@created_at.strftime("%Y.%m.%d, %H:%M")} \n\r \n\r" # дата создания

  	 deadline = "Крайний срок: #{@due_date}" # срок выполнения

  	 return [deadline, @text, time_string] # возвращаем массив
  end
end