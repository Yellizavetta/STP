def count_files_and_folders(directory)
  raise "Директорія не існує" unless Dir.exist?(directory)

  files_count = 0
  folders_count = 0

  # Рекурсивний обхід директорій
  Dir.foreach(directory) do |entry|
    next if entry == '.' || entry == '..' # Пропускаємо поточну та батьківську директорії
    path = File.join(directory, entry)

    if File.directory?(path)
      folders_count += 1  # Лічимо папку
      sub_counts = count_files_and_folders(path)
      files_count += sub_counts[:files]
      folders_count += sub_counts[:folders]
    elsif File.file?(path)
      files_count += 1
    end
  end

  { files: files_count, folders: folders_count }
end

# Введення та виведення результатів
puts "Введіть шлях до директорії:"
input_directory = gets.chomp

begin
  result = count_files_and_folders(input_directory)
  puts "Кількість файлів: #{result[:files]}"
  puts "Кількість папок: #{result[:folders]}"
rescue => e
  puts "Помилка: #{e.message}"
end
