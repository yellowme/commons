RSpec.describe Commons::Concerns::Attributes::Sex do
  let(:sex) { Commons::Concerns::Attributes::Sex::FEMALE }
  let(:user) { build(:user, name: 'rosa del barrio', last_name: 'hernandez', sex: sex) }

  subject do
    user
  end

  describe 'works ok!' do
    it 'when valid data' do
      expect(subject.sex).to eq sex
      expect(subject.female_sex?).to be true
    end
  end

  describe 'fails' do
    subject do
      user = User.new(sex: 'sex')
    end
    it 'when invalid sex' do
      expect{ subject }.to raise_error(ArgumentError)
    end
  end
end
