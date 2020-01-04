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

    it "when model deleted do update" do
      model = subject
      model.deleted_at = Time.current
      model.save
      model.created_at = Time.current
      expect{model.save}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "when model not deleted" do
      model = subject
      model.deleted_at = nil
      model.save
      expect(subject.deleted?).to be false
    end

    it "when model not deleted save" do
      model = subject
      model.deleted_at = nil
      model.created_at = Time.current
      expect{model.save}.not_to raise_error
    end
  end
end
