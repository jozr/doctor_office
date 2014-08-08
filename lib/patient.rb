class Patient

  attr_reader :id, :name, :birthdate, :doctor_id

  def initialize(hash)
    @id = hash['id']
    @name = hash['name']
    @birthdate = hash['birthdate']
    @doctor_id = hash['doctor_id']
  end

  def save
    results = DB.exec("INSERT INTO patient (name, birthdate, doctor_id) VALUES ('#{@name}', '#{@birthdate}', #{@doctor_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec('SELECT * FROM patient;')
    patients = []
    results.each do |result|
      id = result['id'].to_i
      name = result['name']
      birthdate = result['birthdate']
      doctor_id = result['doctor_id'].to_i
      patients << Doctor.new({'id' => id, 'name' => name, 'birthdate' => birthdate, 'doctor_id' => doctor_id})
    end
  patients
  end

  def edit_name(new_name)
    DB.exec("UPDATE patient SET name = '#{new_name}' WHERE name = '#{@name}';")
    @name = new_name
  end

  def edit_birthdate(new_birthdate)
    DB.exec("UPDATE patient SET birthdate = '#{new_birthdate}' WHERE name = '#{@name}';")
    @birthdate = new_birthdate
  end

  def edit_doctor_id(new_doctor_id)
    DB.exec("UPDATE patient SET doctor_id = '#{new_doctor_id}' WHERE name = '#{@name}';")
    @doctor_id = new_doctor_id
  end

  def ==(another_name)
    self.name == another_name.name
  end


end
