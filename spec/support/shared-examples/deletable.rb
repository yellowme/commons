RSpec.shared_examples_for "deletable" do |attrs|
  let(:model) { described_class }

  describe "works ok!" do
    let(:obj) { FactoryBot.create(model.to_s.underscore.to_sym) }
    subject do
      obj
    end

    it "when model deleted" do
      model = subject
      model.deleted_at = Time.current
      model.save
      expect(model.deleted?).to be true
    end

    it "when model not deleted" do
      model = subject
      model.deleted_at = nil
      model.save
      expect(subject.deleted?).to be false
    end
  end
end
