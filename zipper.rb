=begin
module Parser_program
  class Zipper
    class << self
      def create_archive(name_of_archive)
        archive_path = "#{Parser_program.path_to_zip}#{name_of_archive}"

        Zip::File.open(archive_path, Zip::File::CREATE) do |zipfile|
          entries = Dir.entries(Parser_program::path) - %w[. ..]

          entries.each do |entry|
            entry_path = File.join(Parser_program::path, entry)
            entry_name = entry

            # Перевірка, чи існує вже такий файл в архіві
            existing_entry = zipfile.find_entry(entry_name)

            if existing_entry
              puts "Replacing existing file: #{entry_name}"
              # Замінюємо існуючий файл
              zipfile.replace(entry_name, entry_path)
            else
              puts "Adding new file: #{entry_name}"
              # Додаємо новий файл до архіву
              zipfile.add(entry_name, entry_path) if File.file?(entry_path)
            end
          end
        end
      end
    end
  end
end
=end
module Parser_program
  class Zipper
    class << self
      def create_archive(name_of_archive, allowed_extensions)
        archive_path = "#{Parser_program.path_to_zip}#{name_of_archive}"

        Zip::File.open(archive_path, Zip::File::CREATE) do |zipfile|
          entries = Dir.entries(Parser_program::path) - %w[. ..]

          entries.each do |entry|
            entry_path = File.join(Parser_program::path, entry)
            entry_name = entry

            # Перевірка, чи існує вже такий файл в архіві
            existing_entry = zipfile.find_entry(entry_name)

            if existing_entry
              puts "Replacing existing file: #{entry_name}"
              # Замінюємо існуючий файл
              zipfile.replace(entry_name, entry_path)
            elsif File.file?(entry_path) && allowed_extensions.include?(File.extname(entry_name))
              puts "Adding new file: #{entry_name}"
              # Додаємо новий файл до архіву
              zipfile.add(entry_name, entry_path)
            end
          end
        end
      end
    end
  end
end
