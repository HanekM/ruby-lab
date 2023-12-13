module Parser_program
  class MainApplication

    def run(file_ext = Parser_program.file_ext, condition = Parser_program.condition, number = "", name_of_archive = 'data.zip')
      cart = Cart.new
      items = Parser.parse_items(condition)

      items.each do |item|
        cart.add_item(item)
        item.info do |item|
          puts "Об'єкт '#{item.to_s}', добавлений до файлу"
        end
      end

      #puts items[1] <=> items[2]
      #cart.show_all_items_by_title
      file_ext.each do |element|
        case element
        when ".txt"
          cart.save_to_file(number)
        when ".csv"
          cart.save_to_csv(number)
        when ".json"
          cart.save_to_json(number)
        when ".yaml"
          cart.save_to_yaml(number)
        else
          puts "Invalid format"
        end
      end

      Parser_program::Zipper.create_archive(name_of_archive, file_ext)

    end
  end
end