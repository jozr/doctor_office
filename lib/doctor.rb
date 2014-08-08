class Doctor

  attr_reader :id, :name, :specialty_id, :insurance_id

  def initialize(hash)
    @id = hash['id']
    @name = hash['name']
    @specialty_id = hash['specialty_id']
    @insurance_id = hash['insurance_id']
  end

  def save
    results = DB.exec("INSERT INTO doctor (name, specialty_id, insurance_id) VALUES ('#{@name}', #{@specialty_id}, #{@insurance_id}) RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec('SELECT * FROM doctor;')
    doctors = []
    results.each do |result|
      id = result['id'].to_i
      name = result['name']
      specialty_id = result['specialty_id'].to_i
      insurance_id = result['insurance_id'].to_i
      doctors << Doctor.new({'id' => id, 'name' => name, 'specialty_id' => specialty_id, 'insurance_id' => insurance_id})
    end
  doctors
  end

  def self.return_by_specialty(specialty_number)
    results = DB.exec("SELECT * FROM doctor WHERE specialty_id = '#{specialty_number}'")
    doctors = []
    results.each do |result|
      id = result['id'].to_i
      name = result['name']
      specialty_id = result['specialty_id'].to_i
      insurance_id = result['insurance_id'].to_i
      doctors << Doctor.new({'id' => id, 'name' => name, 'specialty_id' => specialty_id, 'insurance_id' => insurance_id})
    end
    doctors
  end

  def self.show_all(input_doctor_name)
    result_name = DB.exec("SELECT * FROM doctor WHERE name = '#{input_doctor_name}'")
    result_id = result_name.first['id'].to_i
    results = DB.exec("SELECT * FROM patient WHERE doctor_id = #{result_id}")
    doctor_patients = []
    results.each do |result|
      patient = result['name']
      doctor_patients << patient
    end
    the_result = ("#{result_name.first['name']} has #{doctor_patients.length} patients")
  end

  def ==(another_name)
    self.name == another_name.name
  end

  def edit_name(new_name)
    DB.exec("UPDATE doctor SET name = '#{new_name}' WHERE name = '#{@name}';")
    @name = new_name
  end

  def edit_specialty(new_specialty_id)
    DB.exec("UPDATE doctor SET specialty_id = '#{new_specialty_id}' WHERE name = '#{@name}';")
    @specialty_id = new_specialty_id
  end

  def edit_insurance(new_insurance_id)
    DB.exec("UPDATE doctor SET insurance_id = '#{new_insurance_id}' WHERE name = '#{@name}';")
    @insurance_id = new_insurance_id
  end

end
