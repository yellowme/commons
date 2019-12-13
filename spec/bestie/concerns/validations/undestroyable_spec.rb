require 'spec_helper'

RSpec.describe 'Bestie::Concerns::Validations::Undestroyable' do
  let(:user) { create(:user) }

  it 'works ok!' do
    expect { user.destroy }.to raise_error Bestie::Errors::Unauthorized
  end
end
