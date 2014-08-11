require 'spec_helper'
require 'pry'

describe Appointment do

  it 'is initialized with an id, doctor id, patient id, date and cost' do
    appointment = Appointment.new({'doctor_id' => 2, 'patient_id' => 5, 'date' => '3/31/1993', 'cost' => 50})
    appointment.should be_an_instance_of Appointment
  end

  it 'saves an appointment to the appointment table' do
    appointment = Appointment.new({'doctor_id' => 2, 'patient_id' => 5, 'date' => '3/31/1993', 'cost' => 50})
    appointment.save
    Appointment.all.first.date.should eq '1993-03-31 12:00:00 -0800'
  end

  it "takes a doctor ID and a date range and returns the cost" do
    appointment1 = Appointment.new({'doctor_id' => 2, 'date' => '1993-01-01', 'cost' => 50 })
    appointment1.save
    appointment2 = Appointment.new({'doctor_id' => 2, 'date' => '1993-01-02', 'cost' => 50 })
    appointment2.save
    appointment3 = Appointment.new({'doctor_id' => 2, 'date' => '1993-01-03', 'cost' => 50 })
    appointment3.save
    Appointment.total(2, '1993-01-01', '1993-01-02').should eq 100
  end
end
