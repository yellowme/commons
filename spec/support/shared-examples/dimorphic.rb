RSpec.shared_examples_for "dimorphic" do |attrs|
  let(:model) { described_class }

  describe "works ok!" do
    let(:sex) { Commons::Concerns::Attributes::Sex::FEMALE }
    let(:obj) { FactoryBot.build(model.to_s.underscore.to_sym) }
    subject do
      obj.sex = sex
      obj
    end

    it "when value dimorphic" do
      expect(subject.sex).to eq sex
      expect(subject.female_sex?).to be true
    end
  end

  describe "fails!" do
    let(:obj) { FactoryBot.build(model.to_s.underscore.to_sym) }
    subject do
      obj.sex = 'random string'
    end

    it "when value not dimorphic" do
      expect{ subject }.to raise_error(ArgumentError)
    end
  end
end
