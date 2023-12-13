require_relative 'libs'

app = Parser_program::Engine.new()
app.run
#Parser_program::SendMail.send_archive


puts "Програма успішно виконана. Перевірте файл."