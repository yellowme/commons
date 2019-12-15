RSpec.describe Commons::Authentication::JSONWebToken do
  let(:user) { create(:user) }
  let(:exp) { 24.hours.from_now }
  let(:jwt) { Commons::Authentication::JSONWebToken.encode({ user_id: user.id }, exp) }

  describe 'decode' do
    subject { Commons::Authentication::JSONWebToken.decode(jwt) }

    context 'works ok' do
      it do
        expect { subject }.not_to raise_error
        expect(subject[:user_id]).not_to be_nil
        expect(subject[:expires_at]).not_to be_nil
        expect(subject[:user_id]).to eq user.id
        expect(subject[:expires_at]).to eq exp.to_i
      end
    end

    context 'raises error when invalid' do
      let(:jwt) { Faker::Name.last_name }
      it do
        expect { subject }.to raise_error JWT::DecodeError
      end
    end
  end

  describe 'encode' do
    subject { Commons::Authentication::JSONWebToken.encode({ user_id: user.id }, exp) }

    context 'works ok' do
      it { expect { subject }.not_to raise_error }
      it do
        token = Commons::Authentication::JSONWebToken.decode(subject)
        expect(token[:user_id]).not_to be_nil
        expect(token[:user_id]).to eq user.id
        expect(token[:expires_at]).not_to be_nil
        expect(token[:expires_at]).to eq exp.to_i
      end
    end
  end
end
