# count_files_and_folders_spec.rb
require 'rspec'
require 'fileutils' 
require_relative 'pr1'  

RSpec.describe '#count_files_and_folders' do
  let(:temp_dir) { 'spec_temp_dir' }

  before do
    FileUtils.rm_rf(temp_dir)  
    Dir.mkdir(temp_dir)
    File.write("#{temp_dir}/file1.txt", "Hello, world!")
    File.write("#{temp_dir}/file2.txt", "Hello again!")
    Dir.mkdir("#{temp_dir}/subdir")
    File.write("#{temp_dir}/subdir/file3.txt", "Nested file")
  end

  after do
    FileUtils.rm_rf(temp_dir)
  end

  it 'підраховує кількість файлів і папок у директорії' do
    result = count_files_and_folders(temp_dir)
    expect(result[:files]).to eq(3)   
    expect(result[:folders]).to eq(1)  
  end

  it 'повертає помилку, якщо директорія не існує' do
    expect { count_files_and_folders('non_existent_directory') }.to raise_error("Директория не существует")
  end

  it 'підраховує порожню директорію як 0 файлів і 0 папок' do
    empty_dir = "#{temp_dir}/empty_dir"
    Dir.mkdir(empty_dir)
    result = count_files_and_folders(empty_dir)
    expect(result[:files]).to eq(0)   # Немає файлів
    expect(result[:folders]).to eq(0)  # Немає підкаталогів  
  end

  it 'підраховує тільки файли в директорії' do
    result = count_files_and_folders("#{temp_dir}/subdir")
    expect(result[:files]).to eq(1)   # Один файл у підкаталозі
    expect(result[:folders]).to eq(0)  # Немає підкаталогів  
  end 
end
