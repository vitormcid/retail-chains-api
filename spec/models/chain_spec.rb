require 'rails_helper'

RSpec.describe Chain, :type => :model do
  subject {
    described_class.new(name: "user", cnpj: "47439035000195")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid with an invalid cnpj" do
    subject.cnpj= "12356789"
    expect(subject).to_not be_valid
  end

end