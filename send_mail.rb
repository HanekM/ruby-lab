module Parser_program
  class SendMail
    class << self
      def send_archive(name_of_archive = 'data.zip')
        Pony.mail({
          :to => 'oleh122333@gmail.com',
          :via => :smtp,
          :via_options => {
            :address              => 'smtp.gmail.com',
            :port                 => '587',
            :enable_starttls_auto => true,
            :user_name            => Parser_program::User.email,
            :password             => Parser_program::User.app_password,
            :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
            :domain               => "gmail.com" # the HELO domain provided by the client to the server
          },
          :subject => 'Архів з файлом',
          :body => 'До цього листа прикріплений архів із файлом',
          :attachments => {"#{name_of_archive}" => File.read("#{Parser_program.path_to_zip}#{name_of_archive}")}
        }) 
      end
    end
  end
end

