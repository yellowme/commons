require 'spec_helper'

RSpec.describe Commons::Concerns::Validations::Undestroyable do
  let(:user) { create(:user) }

  it 'works ok!' do
    expect { user.destroy }.to raise_error Commons::Errors::Unauthorized
  end
end
