RSpec.describe Commons::Concerns::Extensions::Deleted do
  let(:user) { create(:user) }

  subject do
    user
  end

  describe 'works ok!' do
    it 'when existing user' do
      expect(subject.deleted?).to eq false
    end

    it 'when deleted user' do
      # given
      user = subject
      user = UserRepository.instance.soft_delete!(user.id)
      # do
      expect(user.deleted?).to eq true
    end

    it 'when model is not deletable' do
      # given
      employee = Employee.new
      # do
      expect{ employee.deleted? }.to raise_error(ActiveModel::MissingAttributeError)
    end
  end
end
