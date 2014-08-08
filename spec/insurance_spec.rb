require 'spec_helper'

describe Insurance do
  it 'is initialized with an id and name' do
    insurance = Insurance.new ({'name' => 'Red Shield'})
    insurance.should be_an_instance_of Insurance
  end

  it 'lets you save multiple insurances and return all from the database' do
    insurance = Insurance.new({'name' => 'Sue'})
    insurance.save
    insurance2 = Insurance.new({'name' => 'Jim'})
    insurance2.save
    Insurance.all.should eq [insurance, insurance2]
  end

  it 'allows you to edit insurance name' do
    insurance = Insurance.new ({'name' => 'Sue'})
    insurance.save
    insurance.edit_name('blue cross')
    insurance.name.should eq 'blue cross'
  end
end
