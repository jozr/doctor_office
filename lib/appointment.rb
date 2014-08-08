require 'chronic'

class Appointment

  attr_reader :id, :doctor_id, :patient_id, :date, :cost

  def initialize(hash)
    @id = hash['id'].to_i
    @doctor_id = hash['doctor_id'].to_i
    @patient_id = hash['patient_id'].to_i
    @date = hash['date']
    @cost = hash['cost']
  end

  def save
    chroniced = Chronic.parse(@date)
    results = DB.exec("INSERT INTO appointment (id, doctor_id, patient_id, date, cost) VALUES (#{@id}, #{@doctor_id}, #{@patient_id}, '#{chroniced}', '#{cost}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def self.all
    results = DB.exec('SELECT * FROM appointment;')
    appointments = []
    results.each do |result|
      id = result['id'].to_i
      doctor_id = result['doctor_id'].to_i
      patient_id = result['patient_id'].to_i
      date = result['date']
      cost = result['cost']
      appointments << Appointment.new({'id' => id, 'doctor_id' => doctor_id, 'patient_id' => patient_id, 'date' => date, 'cost' => cost})
    end
  appointments
  end

  def ==(another_id)
    self.id == another_id.id
  end

end
