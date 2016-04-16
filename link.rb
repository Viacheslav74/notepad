# encoding: UTF-8

class Link < Post # объявление дочернего класса Link. Post - родительский класс

  def initialize
    super # команда означает взять конструктор или метод из родительского класса

    @url = '' # инициализируем специфичное для класса Link поле ссылки
  end

  def read_from_console
  	# Мы полностью переопределяем метод read_from_console родителя Post

  	# Попросим у пользователя адрес ссылки
    puts "Введите адрес ссылки:"
    @url = STDIN.gets.chomp

    # И описание ссылки (одной строчки будет достаточно)
    puts "Напишите пару слов о том, куда ведёт ссылка"
    @text = STDIN.gets.chomp

  end

  def to_strings
  	time_string = "Создано: #{@created_at.strftime("%Y.%m.%d, %H:%M")} \n\r \n\r" # дата создания
  	return [@url, @text, time_string] # возвращаем массив
  end

  def to_db_hash
    # вызываем родительский метод ключевым словом super и к хэшу, который он вернул
    # присоединяем прицепом специфичные для этого класса поля методом Hash#merge
    return super.merge(
      {
        'text' => @text,
        'url' => @url
      }
    )
  end

   # загружаем свои поля из хэш массива
  def load_data(data_hash)
    super(data_hash) # сперва дергаем родительский метод для общих полей

    # теперь прописываем свое специфичное поле
   
    @text = data_hash['text'].split('\n\r')
    @url = data_hash['url']
  end
end