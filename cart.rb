module Parser_program
  class Cart
    include ItemContainer 

    def initialize
      @items = []
    end
  
    def save_to_file(number)
      File.open("#{Parser_program.path}/data#{number}.txt", "w") do |file|
        file.puts "Cart contents:"
        file.puts "-" * 40
        @items.each do |item|
          file.puts item.to_s 
        end
        file.puts "-" * 40
        file.puts "Total items: #{total_items}"
        file.puts "Average rating: #{average_rating}"
      end
    end
  
    def save_to_json(number)

      File.open("#{Parser_program.path}/data#{number}.json", "w") do |file|
        file.puts JSON.pretty_generate(to_h)
      end
    end
  
    def save_to_csv(number)
      CSV.open("#{Parser_program.path}/data#{number}.csv", "w") do |csv|
        csv << ["Title", "Year", "Duration", "Age limit", "Rating", "Votes"] 
        @items.each do |item|
          csv << item.to_h.values
        end
      end
    end

    def save_to_yaml(number)
      File.open("#{Parser_program.path}/data#{number}.yaml", "w") do |file|
        file.puts YAML.dump(to_h)
      end
    end

  end  
end
