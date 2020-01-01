RSpec.describe Commons::Concerns::Extensions::Deleted do
  let(:user) { create(:user) }

  subject do
    user
  end

  describe 'works ok!' do
    it 'when existing user' do
      expect(subject.deleted?).to eq false
    end

    it 'when existing user allows save' do
      subject.name = Faker::Name.first_name
      expect{ subject.save }.not_to raise_error
    end

    it 'when deleted user' do
      # given
      user = subject
      user = UserRepository.instance.soft_delete!(user.id)
      # do
      expect(user.deleted?).to eq true
    end

    it 'when deleted user denies save' do
      # given
      user = subject
      user = UserRepository.instance.soft_delete!(user.id)
      user.name = Faker::Name.first_name
      # do
      expect{ user.save }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'when model is not deletable' do
      # given
      employee = Employee.new
      # do
      expect{ employee.deleted? }.to raise_error(ActiveModel::MissingAttributeError)
    end
  end
end
