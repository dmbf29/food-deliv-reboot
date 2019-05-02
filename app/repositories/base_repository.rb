class BaseRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @elements = []
    @next_id = 1
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @elements
  end

  def add(element) # an instance of element!
    # hash_name[key] = new_value
    element.id = @next_id
    @next_id += 1
    @elements << element
    save_to_csv
  end

  def find(id)
    @elements.find { |element| element.id == id }
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      @elements << build_element(row)
    end
    @next_id = @elements.empty? ? 1 : @elements.last.id + 1
  end

  def save_to_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << @elements.first.class.headers # class method
      @elements.each do |element|
        csv << element.build_row
      end
    end
  end
end
