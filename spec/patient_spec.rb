require 'spec_helper'

describe Patient do
  it 'is initialized with an id, name, birthdate, and doctor id' do
    patient = Patient.new ({'name' => 'Lisa', 'birthdate' => '03/31/1993', 'doctor_id' => 1})
    patient.should be_an_instance_of Patient
  end

  it 'lets you save multiple patients and return all from the database' do
    patient = Patient.new({'name' => 'Sue', 'birthdate' => '03/31/1993', 'doctor_id' => 1})
    patient.save
    patient2 = Patient.new({'name' => 'Jim', 'birthdate' => '03/31/1993', 'doctor_id' => 1})
    patient2.save
    Patient.all.should eq [patient, patient2]
  end

  it 'allows you to edit a patient' do
    patient = Patient.new ({'name' => 'Sue', 'birthdate' => '1/4/1996', 'doctor_id' => 1})
    patient.save
    patient.edit_name('Foo')
    patient.edit_birthdate('2/4/1996')
    patient.edit_doctor_id(3)
    patient.name.should eq 'Foo'
    patient.birthdate.should eq '2/4/1996'
    patient.doctor_id.should eq 3
  end

end
