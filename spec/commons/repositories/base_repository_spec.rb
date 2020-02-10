RSpec.describe Commons::Repositories::BaseRepository do
  let(:user) { create(:user) }
  let(:valid_params) do
    {
      name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    }
  end

  describe 'all' do
    context 'when data exists' do
      let(:users_amount) { 10 }
      let(:deleted_users_amount) { 5 }
      before do
        users_amount.times {
          UserRepository.instance.create_from_params!(**valid_params.to_h.symbolize_keys)
        }
        deleted_users_amount.times {
          user = UserRepository.instance.create_from_params!(**valid_params.to_h.symbolize_keys)
          UserRepository.instance.destroy!(user)
        }
      end
      subject { UserRepository.instance.all }

      it do
        expect(subject.count).to eq users_amount + deleted_users_amount
        expect(subject.first).to be_an_instance_of User
      end
    end

    context 'when no data' do
      it { expect(UserRepository.instance.all).to be_empty }
    end
  end

  describe 'deleted' do
    context 'when data exists' do
      let(:users_amount) { 10 }
      let(:deleted_users_amount) { 5 }
      before do
        users_amount.times {
          UserRepository.instance.create_from_params!(**valid_params.to_h.symbolize_keys)
        }
        deleted_users_amount.times {
          user = UserRepository.instance.create_from_params!(**valid_params.to_h.symbolize_keys)
          UserRepository.instance.destroy!(user)
        }
      end
      subject { UserRepository.instance.deleted }

      it do
        expect(subject.count).to eq deleted_users_amount
      end
    end

    context 'when no data' do
      let(:users_amount) { 10 }
      before do
        users_amount.times {
          UserRepository.instance.create_from_params!(**valid_params.to_h.symbolize_keys)
        }
      end

      it { expect(UserRepository.instance.deleted).to be_empty }
    end
  end

  describe 'find' do
    context 'by a valid id' do
      subject { UserRepository.instance.find(user.id) }

      it { is_expected.to be_an_instance_of User }
    end

    context 'by non-existent id' do
      it do
        expect do
          UserRepository.instance.find('my totally non-existent id')
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'find_deleted' do
    context 'by a valid id' do
      subject { UserRepository.instance.find_deleted(user.id) }

      it { is_expected.to be_nil }
    end

    context 'by non-existent id' do
      subject { UserRepository.instance.find_deleted('my totally non-existent id') }

      it { is_expected.to be_nil }
    end

    context 'by previously deleted user' do
      before do
        UserRepository.instance.destroy!(user)
      end

      subject { UserRepository.instance.find_deleted(user.id) }

      it { is_expected.to be_an_instance_of User }
    end
  end

  describe 'find_by' do
    context 'by a valid id' do
      subject { UserRepository.instance.find_by(id: user.id) }

      it { is_expected.to be_an_instance_of User }
    end

    context 'by non-existent id' do
      it { expect(UserRepository.instance.find_by(id: 'my totally non-existent id')).to be_falsey }
    end
  end

  describe 'find_deleted_by' do
    context 'by a valid id' do
      subject { UserRepository.instance.find_deleted_by(id: user.id) }

      it { is_expected.to be_falsey }
    end

    context 'by non-existent id' do
      subject { UserRepository.instance.find_deleted_by(id: 'my totally non-existent id') }

      it { is_expected.to be_falsey }
    end

    context 'by previously deleted user' do
      before do
        UserRepository.instance.destroy!(user)
      end

      subject { UserRepository.instance.find_deleted_by(id: user.id) }

      it { is_expected.to be_an_instance_of User }
    end
  end

  describe 'find_by!' do
    context 'by a valid id!' do
      subject { UserRepository.instance.find_by!(id: user.id) }

      it { is_expected.to be_an_instance_of User }
    end

    context 'by non-existent id!' do
      it do
        expect do
          UserRepository.instance.find_by!(
            id: 'my totally non-existent id'
          )
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'find_deleted_by!' do
    context 'by a valid active id' do
      subject { UserRepository.instance.find_deleted_by!(id: user.id) }

      it do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'by non-existent id!' do
      subject { UserRepository.instance.find_deleted_by!(id: 'my totally non-existent id') }

      it do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'by previously deleted user' do
      before do
        UserRepository.instance.destroy!(user)
      end

      subject { UserRepository.instance.find_deleted_by!(id: user.id) }

      it { is_expected.to be_an_instance_of User }
    end
  end

  describe 'find_or_create_by!' do
    describe 'works ok!' do
      context 'when exists' do
        let(:previous_user) { UserRepository.instance.create_from_params!(**valid_params.to_h.symbolize_keys) }
        before do
          previous_user
        end
        subject { UserRepository.instance.find_or_create_by!(**valid_params.to_h.symbolize_keys) }

        it do
          expect(subject).to be_an_instance_of User
          expect(subject.id).to eq previous_user.id
          expect(subject.name).to eq valid_params[:name]
          expect(subject.last_name).to eq valid_params[:last_name]
        end
      end

      context 'when creates' do
        let(:previous_valid_params) do
          {
            name: 'Johnny',
            last_name: Faker::Name.last_name
          }
        end
        let(:previous_user) { UserRepository.instance.create_from_params!(**previous_valid_params.to_h.symbolize_keys) }
        before do
          previous_user
        end
        subject { UserRepository.instance.find_or_create_by!(**valid_params.to_h.symbolize_keys) }

        it do
          expect(subject).to be_an_instance_of User
          expect(subject.id).not_to eq previous_user.id
          expect(subject.name).to eq valid_params[:name]
          expect(subject.last_name).to eq valid_params[:last_name]
        end
      end
    end

    context 'fails ok!' do
      let(:invalid_params) do
        {
          last_name: Faker::Name.last_name,
          age: 18
        }
      end

      subject { UserRepository.instance.find_or_create_by!(**invalid_params.to_h.symbolize_keys) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end

  describe 'where_first_or_create!' do
    describe 'works ok!' do
      context 'when exists' do
        let(:previous_user) { UserRepository.instance.create_from_params!(**valid_params.to_h.symbolize_keys) }
        let(:new_params) do
          {
            name: 'Jhonny',
            last_name: 'Be Good'
          }
        end
        before do
          previous_user
        end
        subject { UserRepository.instance.where_first_or_create!({ name: valid_params[:name]}, **new_params.to_h.symbolize_keys) }

        it do
          expect(subject).to be_an_instance_of User
          expect(subject.id).to eq previous_user.id
          expect(subject.name).to eq valid_params[:name]
          expect(subject.last_name).to eq valid_params[:last_name]
        end
      end

      context 'when creates' do
        let(:previous_user) { UserRepository.instance.create_from_params!(**valid_params.to_h.symbolize_keys) }
        let(:new_params) do
          {
            name: 'Jhonny',
            last_name: 'Be Good'
          }
        end
        before do
          previous_user
        end
        subject { UserRepository.instance.where_first_or_create!({ name: new_params[:name]}, **new_params.to_h.symbolize_keys) }

        it do
          expect(subject).to be_an_instance_of User
          expect(subject.id).not_to eq previous_user.id
          expect(subject.name).to eq new_params[:name]
          expect(subject.last_name).to eq new_params[:last_name]
        end
      end
    end

    context 'fails ok!' do
      let(:invalid_params) do
        {
          last_name: Faker::Name.last_name,
          age: 18
        }
      end

      subject { UserRepository.instance.where_first_or_create!({last_name: valid_params[:last_name]}, **invalid_params.to_h.symbolize_keys) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end

  describe 'create!' do
    describe 'works when' do
      context 'using a valid user' do
        let(:user) { build(:user) }

        subject { UserRepository.instance.create!(user) }

        it { expect(subject).to be true }
      end
    end

    describe 'fails when' do
      context 'is not a user' do
        let(:employee) { build(:employee) }

        it do
          expect do
            UserRepository.instance.create!(employee)
          end.to raise_error(ArgumentError)
        end
      end

      context 'is not a valid user' do
        let(:user) { build(:user, name: nil) }

        it do
          expect do
            UserRepository.instance.create!(user)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end

  describe 'create_from_params!' do
    context 'works ok!' do
      subject { UserRepository.instance.create_from_params!(**valid_params.to_h.symbolize_keys) }

      it do
        expect(subject).to be_an_instance_of User
        expect(subject.name).to eq valid_params[:name]
        expect(subject.last_name).to eq valid_params[:last_name]
      end
    end

    context 'fails ok!' do
      let(:invalid_params) {}

      subject { UserRepository.instance.create_from_params!(**invalid_params.to_h.symbolize_keys) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end

  describe 'update!' do
    describe 'works when' do
      context 'using a valid user' do
        let(:user) { create(:user) }

        subject { UserRepository.instance.update!(user) }

        it { expect(subject).to be true }
      end
    end

    describe 'fails when' do
      context 'is not a user' do
        let(:employee) { create(:employee) }

        it do
          expect do
            UserRepository.instance.update!(employee)
          end.to raise_error(ArgumentError)
        end
      end

      context 'is not a previously saved' do
        let(:user) { build(:user) }

        it do
          expect do
            UserRepository.instance.update!(user)
          end.to raise_error(ArgumentError)
        end
      end

      context 'is not a valid user' do
        let(:user) { create(:user) }
        let(:invalid_user) do
          user.name = nil
          user
        end

        it do
          expect do
            UserRepository.instance.update!(invalid_user)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end

  describe 'update_from_params!' do
    context 'works ok!' do
      subject { UserRepository.instance.update_from_params!(id: user.id, **valid_params.to_h.symbolize_keys) }

      it do
        expect(subject).to be_an_instance_of User
        expect(subject.name).to eq valid_params[:name]
        expect(subject.last_name).to eq valid_params[:last_name]
      end
    end

    describe 'fails ok!' do
      context 'if invalid params' do
        let(:invalid_params) do
          {
            name: nil
          }
        end

        subject { UserRepository.instance.update_from_params!(id: user.id, **invalid_params.to_h.symbolize_keys) }

        it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
      end

      context 'by a unknown param' do
        it do
          expect do
            UserRepository.instance.update_from_params!(
              id: user.id,
              data: 'dummy'
            )
          end.to raise_error(ActiveRecord::UnknownAttributeError)
        end
      end

      context 'if not found' do
        subject { UserRepository.instance.update_from_params!(id: Faker::Number.number(digits: 2), **valid_params.to_h.symbolize_keys) }

        it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end
  end

  describe 'soft_delete' do
    describe 'works when' do
      context 'using a valid user' do
        let(:user) { create(:user) }

        subject { UserRepository.instance.destroy!(user) }

        it { expect(subject.deleted_at).not_to be nil }
      end
    end

    describe 'fails when' do
      context 'is not deletable' do
        let(:employee) { create(:employee) }

        it do
          expect do
            EmployeeRepository.instance.destroy!(employee)
          end.to raise_error(ActiveModel::MissingAttributeError)
        end
      end

      context 'is not a valid user' do
        let(:user) { create(:user, deleted_at: Time.current) }

        it do
          expect do
            UserRepository.instance.destroy!(user)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end
