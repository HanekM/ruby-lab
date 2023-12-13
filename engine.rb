module Parser_program
  class Engine
    def run
      ts = (1..4).map do |i|
        Thread.new do
          Thread.current[:name] = "thread#{i}"
          puts "####Done #{i}"
          app = Parser_program::MainApplication.new()
          app.run([Parser_program.file_ext[i-1]], condition = ->(item) {item.age_limit == Parser_program.age_limits[i-1] }, "#{i}", "data#{i}.zip")
          #Parser_program::SendMail.send_archive("data#{i}.zip")
        end
      end 
      puts "Start main thread"
      Thread.list.each {|t| p t}
      begin 
          result = ts.map(&:value)
          #puts result
      rescue => ex
          puts "exception: #{ex.inspect}"
      ensure 
          ts.each {|t| puts "#{t[:name]} - finish"}
          puts "done with main thread"
      end
    end
  end
end