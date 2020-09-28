require 'rails_helper'

RSpec.describe Visitor, :type => :model do
  subject {
    described_class.new(name: "user")
  }

  it "is valid with valid attributes" do
    chain = Chain.new(name: "user", cnpj: "47439035000195")
    subject.chain = chain
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    chain = Chain.new(name: "user", cnpj: "47439035000195")
    subject.chain = chain
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a chain" do
    expect(subject).to_not be_valid
  end

  describe "Associations" do 
    it { should belong_to(:chain) }  
  end 

end