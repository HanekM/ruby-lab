module Parser_program

    class << self
        attr_accessor :web_address, :web_address_login, :file_ext, :user, :numbers, :path, :condition, :path_to_zip, :age_limits
        
        def config
            return to_s unless block_given?
            if @parser_program
                puts "\nНеможливо змінити конфігурацію\n" 
                return
            end
            yield self
            @parser_program ||= self
            #@parser_program.freeze
        end
        
        def user(&block)
            @user ||= User.config(&block)
        end
        
        private 

        def to_s
            str = "\nParser program config:\n"
            str += "    web_address: #{@web_address}\n" if @web_address
            str += "    path: #{@path}" if @path
            str += @user.config if @user
            str
        end 

    end
    
    class User 
        class << self
            attr_accessor :email, :password, :app_password
            
            def config(&block)
                return to_s unless block_given?
                
                return @user if @user
                
                yield self
                @user ||= self
                @user.freeze
            end
            
            private 
            
            def to_s
                str = "\nUser config:\n"
                str += "    email: #{@email}\n\n"
            end

        end
    end

end