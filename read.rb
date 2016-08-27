# encoding: UTF-8
# Файл read.rb для чтения из БД, а файл new_post.rb для записи в БД

# Подключаем класс Post и его детей
require_relative 'post.rb'
require_relative 'memo.rb'
require_relative 'link.rb'
require_relative 'task.rb'
require_relative 'tweet.rb'

# будем обрабатывать параметры командной строки по-взрослому с помощью спец. библиотеки руби
require 'optparse' # спец. модуль для красивой работы , встроен в руби

# Все наши опции будут записаны сюда
options = {}
# заведем нужные нам опции
# по которым будем читать из БД - это по id, по limit - последние записи вывести, по type - вывод
# по типу записи
OptionParser.new do |opt|
  opt.banner = 'Usage: read.rb [options]' # такие блоки кода называются Ruby Blocks (в данном случае
  	# с методом opt). banner - это помощь для пользователя

  opt.on('-h', 'Prints this help') do # с параметром -h выводится помощь
    puts opt
    exit
  end
# далее перечислены все опции помощи, которые выведутся. ключи type, id, limit. options - это доп. 
#опции запроса пользователя 
  opt.on('--type POST_TYPE', 'какой тип постов показывать (по умолчанию любой)') { |o| options[:type] = o } #
  opt.on('--id POST_ID', 'если задан id — показываем подробно только этот пост') { |o| options[:id] = o } #
  opt.on('--limit NUMBER', 'сколько последних постов показать (по умолчанию все)') { |o| options[:limit] = o } #

end.parse!
# на выходе вышеприведенного блока получается ассоц. массив options со всеми ключами, которые пользователь
# передал в командной строке

 if !options[:id].nil? # поиск по конкретному id
 
  result = Post.find_by_id(options[:id]) # результат работы метода find_by_id будет
  # зависеть от id

 else 
  result = Post.find_all(options[:limit], options[:type]) # результат работы метода find_all будет
  # зависеть от параметров limit, type
  end

if result.is_a? Post # показываем конкретный пост
  puts "Запись #{result.class.name}, id = #{options[:id]}"
  # выведем весь пост на экран и закроемся
  result.to_strings.each do |line| # у поста есть метод to_strings
    puts line # выводим трочку за строчкой
  end

else # показываем таблицу результатов (так сами решили)

  print "| id\t| @type\t|  @created_at\t\t\t|  @text \t\t\t| @url\t\t| @due_date \t "# шапка таблицы

  result.each do |row| # выводим строчку за строчкой
    puts #пустая строка для разделения
    # puts '_'*80
    row.each do |element|# проходимся по массиву значений (внутренний цикл). Выводим значения всех полей
    # таблицы 
      print "|  #{element.to_s.delete("\\n\\r")[0..40]}\t"# внутри строки выводим элементы используем
      #команду print , чтобы не переходить на новую строку. Отделяем верт чертой - |. 
      # Удаляем переносы строк - delete("\\n\\r"). Берем только первые 40 символов строки для 
      # краткости [0..40]
    end
  end
end

puts #пустая строка для разделения в конце программы

# Фигурные скобки {...} после вызова метода в простых случаях аналогичны конструкции do ... end
# Они ограничивают блок кода который будет выполняться этим методом
#
# см. http://stackoverflow.com/questions/5587264/do-end-vs-curly-braces-for-blocks-in-ruby