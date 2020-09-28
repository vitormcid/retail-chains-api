require 'rails_helper'

RSpec.describe User, :type => :model do
  subject {
    described_class.new(name: "user", username: "username", password: "password123", password_confirmation:"password123", chain_id: 1)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a username" do
    subject.username = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with a  short password" do
    subject.password = "pass"
    subject.password_confirmation = "pass"
    subject.save   
    expect(subject).to_not be_valid
  end

  it "not valid with wrong password confirmation" do
    subject.password = "pass"
    subject.password_confirmation = "wrongpass"
    subject.save   
    expect(subject).to_not be_valid
  end

  describe "Associations" do 
    it { should have_many(:roles) }  
  end

end