# encoding: UTF-8
# Подключим встроенный в руби класс Date для работы с датами
require 'date'

class Task < Post
  def initialize
    super

    @due_date = Time.now # добавляем переменную @due_date специфичную для этого класса.
    #сделаем по умолчанию текущее время. Потом заменим на будущее время.
  end

  def read_from_console

  	# Спросим у пользователя, что за задачу ему нужно сделать
    # Одной строчки будет достаточно
    puts "Что вам необходимо сделать?"
    @text = STDIN.gets.chomp

    # А теперь спросим у пользователя, до какого числа ему нужно это сделать
    # И подскажем формат, в котором нужно вводить дату
    puts "До какого числа вам нужно это сделать?"
    puts "Укажите дату в формате ДД.ММ.ГГГГ, например 12.05.2003"
    input = STDIN.gets.chomp

    # Для того, чтобы записать дату в удобном формате, воспользуемся методом parse класса Date
    @due_date = Date.parse(input) # поле @due_date 
  end

  def to_strings
  	 time_string = "Создано: #{@created_at.strftime("%Y.%m.%d, %H:%M")} \n\r \n\r" # дата создания

  	 deadline = "Крайний срок: #{@due_date}" # срок выполнения

  	 return [deadline, @text, time_string] # возвращаем массив
  end

  def to_db_hash
   # вызываем родительский метод ключевым словом super и к хэшу, который он вернул
    # присоединяем прицепом специфичные для этого класса поля методом Hash#merge
    return super.merge(# с помощью ключ. слова super получаем из метода родительского класса
      {
        'text' => @text, # добавляем в хэш, то что специфично для класса task
        'due_date' => @due_date.to_s
      }
    )
  end

  # загружаем свои поля из хэш массива
  def load_data(data_hash)
    super(data_hash) # сперва дергаем родительский метод для общих полей

    # теперь прописываем свое специфичное поле
    @due_date = Date.parse(data_hash['due_date'])
    @text = data_hash['text'].split('\n\r') # добавил эту строку, чтобы поле text тоже выводилось на экран
  end
end