RSpec.describe 'Bestie::Repositories::BaseRepository' do
  let(:user) { create(:user) }
  let(:valid_params) do
    {
      name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    }
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

  describe 'create!' do
    context 'works ok!' do
      subject { UserRepository.instance.create!(**valid_params.to_h.symbolize_keys) }

      it do
        expect(subject).to be_an_instance_of User
        expect(subject.name).to eq valid_params[:name]
        expect(subject.last_name).to eq valid_params[:last_name]
      end
    end

    context 'fails ok!' do
      let(:invalid_params) {}

      subject { UserRepository.instance.create!(**invalid_params.to_h.symbolize_keys) }

      it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
    end
  end

  describe 'update!' do
    context 'works ok!' do
      subject { UserRepository.instance.update!(id: user.id, **valid_params.to_h.symbolize_keys) }

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

        subject { UserRepository.instance.update!(id: user.id, **invalid_params.to_h.symbolize_keys) }

        it { expect { subject }.to raise_error(ActiveRecord::RecordInvalid) }
      end

      context 'by a unknown param' do
        it do
          expect do
            UserRepository.instance.update!(
              id: user.id,
              data: 'dummy'
            )
          end.to raise_error(ActiveRecord::UnknownAttributeError)
        end
      end

      context 'if not found' do
        subject { UserRepository.instance.update!(id: Faker::Number.number(digits: 2), **valid_params.to_h.symbolize_keys) }

        it { expect { subject }.to raise_error(ActiveRecord::RecordNotFound) }
      end
    end
  end
end
