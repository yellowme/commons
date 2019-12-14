RSpec.describe Bestie::Authentication::AuthenticateByJWT, type: :request do
  describe 'when calling /misc/application_parameters' do
    context 'raises error as an unauthenticated user' do
      subject do
        get "/misc/application_parameters",
            params: {}.to_json,
            headers: {
              'content-type': 'application/json'
            }
        response
      end

      it do
        is_expected.to have_http_status(:unauthorized)
      end
    end

    context 'works ok as an authenticated user' do
      let(:user) { create(:user) }
      let(:jwt) { Bestie::Authentication::JSONWebToken.encode(user_id: user.id) }

      subject do
        get "/misc/application_parameters",
            params: {}.to_json,
            headers: {
              'content-type': 'application/json',
              'Authorization': 'Bearer ' + jwt
            }
        response
      end

      it do
        is_expected.to have_http_status(:ok)
      end
    end
  end
end
