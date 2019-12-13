describe Bestie::Repositories::Catalogs::BaseCatalog, type: :repository do
  # memory store is per process and therefore no conflicts in parallel tests
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
  let(:cache) { Rails.cache }
  let(:value) { true }
  let(:app_param) { create(:application_parameter, value: value) }

  before do
    allow(Rails).to receive(:cache).and_return(memory_store)
    Rails.cache.clear
  end

  context 'create!' do
    let(:params) { { name: 'limit_money', value: 40_000 } }
    subject { Catalogs::ApplicationParameterRepository.instance.create!(params) }
    it do
      expect(cache.exist?('cached_catalogs_application_parameter_repository')).to be(false)
      is_expected.to be_an_instance_of Catalogs::ApplicationParameter
      expect(cache.exist?('cached_catalogs_application_parameter_repository')).to be(false)
    end
  end

  describe 'find_or_create_by!' do
    context 'when exists' do
      let(:params) { { name: app_param.name, value: app_param.value } }
      subject { Catalogs::ApplicationParameterRepository.instance.find_or_create_by!(params) }
      it do
        expect(cache.exist?('cached_catalogs_application_parameter_repository')).to be(false)
        is_expected.to be_an_instance_of Catalogs::ApplicationParameter
        expect(cache.exist?('cached_catalogs_application_parameter_repository')).to be(false)
      end
    end

    context 'when does not exist' do
      let(:params) { { name: 'new_limit_money', value: 40_000 } }
      subject { Catalogs::ApplicationParameterRepository.instance.find_or_create_by!(params) }
      it do
        expect(cache.exist?('cached_catalogs_application_parameter_repository')).to be(false)
        is_expected.to be_an_instance_of Catalogs::ApplicationParameter
        expect(cache.exist?('cached_catalogs_application_parameter_repository')).to be(false)
      end
    end
  end

  context 'update!' do
    let(:params) { { id: app_param.id, value: 40_000 } }

    subject { Catalogs::ApplicationParameterRepository.instance.update!(params) }
    it do
      expect(cache.exist?('cached_catalogs_application_parameter_repository')).to be(false)
      is_expected.to be_an_instance_of Catalogs::ApplicationParameter
      expect(subject.value).to eq params[:value].to_s
      expect(cache.exist?('cached_catalogs_application_parameter_repository')).to be(false)
    end
  end
end
