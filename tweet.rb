# encoding: UTF-8

require 'twitter'
# Класс Твит, разновидность базового класса "Запись"
# основные методы этого класса ничем не будут отличаться от класса memo
class Tweet < Post

  #def initialize по умолчанию конструктор класса Memo можно не писать, потому
  # что он совпадает полностью с конструктором родительского класса

  #end
   @@CLIENT = Twitter::REST::Client.new do |config| # @@переменная класса с двумя собачками (урок 12)
    #эта переменная принедлежит не конкретному объекту, а всем объектам данного класса Tweet
    # ВНИМАНИЕ! Эти параметры уникальны для каждого проиложения, вы должны
    # зарегистрировать в своем аккаунте новое приложение на https://apps.twitter.com
    # и взять со страницы этого приложения данные параметры!
    config.consumer_key = 'pgSysMSgrEfpwYx2rvtfdrKVM'
    config.consumer_secret = 'sG5WW0wHyfJMqXXGDVnpdXgrUZ8lUIyDzlOxQNKJMrs6uJj9VN'
    config.access_token = '738771354380578816-OFTniiBJbVS6W208UdopOI4R9MgkAUG'
    config.access_token_secret = '8tQknHf7LvHr5cLXWmTreR2ia2aUudKuif12zFvXtNCzc'
  end
  
# Метод для чтения твита из консоли
  def read_from_console
  	 # Метод, который спрашивает у пользователя, ввести твит длиной не более 140 символов
   puts 'Новый твит (140 символов!):'

    # считаем твит в переменную text. Выберем только первые 140 символов
    @text = STDIN.gets.chomp[0..140]

    # Отправляем твит в ленту с помощью gem-а
    puts "Отправляем ваш твит: #{@text.encode('utf-8')}"
    @@CLIENT.update(@text.encode('utf-8'))
    puts 'Твит отправлен.'
  end
  
  # Массив из даты создания + тело твита
  def to_strings

  	# запишем в блокнот дату и время записи и сделаем отступ
    # \r – специальный дополнительный символ конца строки для Windows
   	time_string = "Создано: #{@created_at.strftime("%Y.%m.%d, %H:%M:%S")} \n\r \n\r"
    
    return @text.unshift(time_string) # метод unshift добавляет в начало массива строку time_string 

  end

   def to_db_hash
    # вызываем родительский метод ключевым словом super и к хэшу, который он вернул
    # присоединяем прицепом специфичные для этого класса поля методом Hash#merge
    return super.merge(
      {
        'text' => @text#.join('\n\r') # добавляем в хеш массив строк @text. В нем добавляем наш твит
      }
    )
  end

   # загружаем свои поля из хэш массива
  def load_data(data_hash)
    super(data_hash) # сперва дергаем родительский метод для общих полей

    # теперь прописываем свое специфичное поле
    @text = data_hash['text']#.split('\n\r')
  end

end