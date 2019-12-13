require 'support/shared-examples/undestroyable'
require 'support/shared-examples/capitalizable'
require 'support/shared-examples/stripable'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  subject { user }

  context 'shared-example' do
    it_behaves_like "undestroyable"
    it_behaves_like "capitalizable", ['name']
    it_behaves_like "stripable", ['name', 'last_name']
  end
end
