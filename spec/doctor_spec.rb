require 'spec_helper'

describe Doctor do
  it 'is initialized with an id, name, specialty id, and insurance id' do
    doctor = Doctor.new ({'name' => 'Sue', 'specialty_id' => 2, 'insurance_id' => 3})
    doctor.should be_an_instance_of Doctor
  end

  it 'lets you save multiple doctors and return all from the database' do
    doctor1 = Doctor.new({'name' => 'Sue', 'specialty_id' => 2, 'insurance_id' => 3})
    doctor1.save
    doctor2 = Doctor.new({'name' => 'Jim', 'specialty_id' => 1, 'insurance_id' => 3})
    doctor2.save
    Doctor.all.should eq [doctor1, doctor2]
  end

  it 'returns a list of doctors with a given specialty' do
    doctor1 = Doctor.new({'name' => 'Sue', 'specialty_id' => 2, 'insurance_id' => 3})
    doctor1.save
    doctor2 = Doctor.new({'name' => 'Jim', 'specialty_id' => 1, 'insurance_id' => 3})
    doctor2.save
    Doctor.return_by_specialty(2).should eq [doctor1]
  end

  it 'allows you to edit a doctor' do
    doctor = Doctor.new ({'name' => 'Sue', 'specialty_id' => 2, 'insurance_id' => 3})
    doctor.save
    doctor.edit_name('Foo')
    doctor.edit_specialty(3)
    doctor.edit_insurance(2)
    doctor.name.should eq 'Foo'
    doctor.specialty_id.should eq 3
    doctor.insurance_id.should eq 2
  end

  it 'displays a list of all doctors and the number of patients each doctor sees' do
    doctor1 = Doctor.new ({'name' => 'Sue', 'specialty_id' => 2, 'insurance_id' => 3})
    doctor2 = Doctor.new ({'name' => 'Jim', 'specialty_id' => 3, 'insurance_id' => 1})
    doctor1.save
    doctor2.save
    patient1 = Patient.new ({'name' => 'Bill', 'birthdate' => '1/4/1997', 'doctor_id' => doctor1.id})
    patient2 = Patient.new ({'name' => 'Karen', 'birthdate' => '1/4/1996', 'doctor_id' => doctor2.id})
    patient3 = Patient.new ({'name' => 'Phil', 'birthdate' => '1/4/1998', 'doctor_id' => doctor1.id})
    patient1.save
    patient2.save
    patient3.save
    Doctor.show_all(doctor1.name).should eq 'Sue has 2 patients'
  end
end
