RSpec.shared_examples_for "stripable" do |attrs|
  let(:model) { described_class }
  let(:dirty_string) { ' First  Second  ' }

  it "is stripable" do
    params = {}
    attrs.each do |attr|
      params[attr] = dirty_string
    end
    obj = FactoryBot.build(model.to_s.underscore.to_sym, params)
    obj.update!(params)
    attrs.each do |attr|
      value = obj.instance_eval(attr.to_s)
      expect(value).to eq params[attr].to_s.strip.squeeze(" ")
    end
  end
end
