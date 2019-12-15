RSpec.shared_examples_for "undestroyable" do
  let(:model) { described_class }

  it "is undestroyable" do
    obj = FactoryBot.build(model.to_s.underscore.to_sym)
    expect { obj.destroy }.to raise_error Commons::Errors::Unauthorized
  end
end
