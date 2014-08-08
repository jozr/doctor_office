class Insurance

  attr_reader :id, :name

  def initialize(hash)
    @id = hash['id']
    @name = hash['name']
  end

  def save
    results = DB.exec("INSERT INTO insurance (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec('SELECT * FROM insurance;')
    insurances = []
    results.each do |result|
      id = result['id'].to_i
      name = result['name']
      insurances << Insurance.new({'id' => id, 'name' => name})
    end
  insurances
  end

  def edit_name(new_name)
    DB.exec("UPDATE insurance SET name = '#{new_name}' WHERE name = '#{@name}';")
    @name = new_name
  end

  def ==(another_name)
    self.name == another_name.name
  end


end
