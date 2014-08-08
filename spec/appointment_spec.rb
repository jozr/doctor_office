require 'spec_helper'

describe Appointment do

  it 'is initialized with an id, doctor id, patient id, date and cost' do
    appointment = Appointment.new({'doctor_id' => 2, 'patient_id' => 5, 'date' => '3/31/1993', 'cost' => '$50'})
    appointment.should be_an_instance_of Appointment
  end

  it 'saves an appointment to the appointment table' do
    appointment = Appointment.new({'doctor_id' => 2, 'patient_id' => 5, 'date' => '3/31/1993', 'cost' => '$50'})
    appointment.save
    Appointment.all.should eq [appointment]
  end
end
