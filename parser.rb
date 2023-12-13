module Parser_program
  class Parser 

    def self.parse_items(condition)
      items = [] 

      # Створюємо агента Mechanize
      agent = Mechanize.new
      # Отримуємо сторінку за веб-адресою
      page = agent.get(Parser_program.web_address_login)
      # Знаходимо форму для входу за ідентифікатором
      form = agent.page.search('div.a-box-inner')
      #puts form
=begin
      # Вводимо логін та пароль
      form.login = Parser_program::User.email
      form.password = Parser_program::User.password

      # Надсилаємо форму
      result = form.submit

      page = agent.get(Parser_program.web_address)
      puts page
=end
      doc = Nokogiri::HTML(Faraday.get(Parser_program.web_address).body)
      rows = doc.css("div.cli-children") 

      rows.each_with_index do |row, index| 
        break if index == Parser_program.numbers 
      
        title = row.css("h3.ipc-title__text").text.sub(/^\d+\.\s*/, '')
        year = row.css("div.cli-title-metadata span[1]").text.strip[/\d+/]
        duration = row.css("div.cli-title-metadata span[2]").text
        age_limit = row.css("div.cli-title-metadata span[3]").text
        rating = row.css("div.cli-ratings-container span").text.to_f
        votes = row.css("div.cli-ratings-container span.ipc-rating-star--voteCount").text.match(/(\d+\.*\d*)([MK])/)
        votes = votes[1].to_i * (votes[2] == 'M' ? 1_000_000 : 1_000)
      
        attributes = {
          title: title,
          year: year,
          duration: duration,
          age_limit: age_limit,
          rating: rating,
          votes: votes,
        }

        item = Item.new(attributes)
        next unless condition.call(item)
        items << item 
      end 
      items 
    end
  end
end