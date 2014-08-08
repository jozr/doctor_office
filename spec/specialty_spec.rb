require 'spec_helper'

describe Specialty do
  it 'is initialized with an id and name' do
    specialty = Specialty.new ({'name' => 'pediatrician'})
    specialty.should be_an_instance_of Specialty
  end

  it 'lets you save multiple specialties and return all from the database' do
    specialty = Specialty.new({'name' => 'stomach'})
    specialty.save
    specialty2 = Specialty.new({'name' => 'foot'})
    specialty2.save
    Specialty.all.should eq [specialty, specialty2]
  end

  it 'allows you to edit specialty name' do
    specialty = Insurance.new ({'name' => 'Foot'})
    specialty.save
    specialty.edit_name('Leg')
    specialty.name.should eq 'Leg'
  end

end
