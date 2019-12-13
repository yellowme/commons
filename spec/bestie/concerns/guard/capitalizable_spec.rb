RSpec.describe 'Bestie::Concerns::Guard::Capitalizable' do
  let(:user) { build(:user, name: 'rosa del barrio', last_name: 'hernandez') }

  subject do
    user.valid?
    user
  end

  it 'works ok!' do
    expect(subject.name).to eq 'Rosa del Barrio'
    expect(subject.last_name).to eq 'hernandez'
  end
end
