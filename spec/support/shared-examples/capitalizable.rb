RSpec.shared_examples_for "capitalizable" do |attrs|
  let(:model) { described_class }

  it "is capitalizable" do
    params = {}
    attrs.each do |attr|
      params[attr] = Faker::Name.last_name.downcase
    end
    obj = FactoryBot.build(model.to_s.underscore.to_sym, params)
    obj.valid?
    attrs.each do |attr|
      value = obj.instance_eval(attr.to_s)
      expect(value).to eq Buddy::Formatter::StringUtils.capitalize(params[attr])
    end
  end
end
