RSpec.describe Bestie::Errors::MissingParameter, type: :serializer do
  let(:param) { Faker::Name.name }
  let(:message) { Faker::Name.name }
  let(:error) { described_class.new }
  subject do
    serializer = Bestie::Errors::ErrorSerializer.new(error)
    serializer.serializable_hash
  end

  describe 'serialize the model' do
    context 'should validate required attributes' do
      it do
        serialized = subject
        expect(serialized.keys).to include :status
        expect(serialized.keys).to include :code
        expect(serialized.keys).to include :title
        expect(serialized.keys).to include :detail
        expect(serialized.keys).to include :meta
      end
    end

    context 'should work with default values' do
      it do
        serialized = subject
        expect(serialized[:status]).to eq error.status
        expect(serialized[:code]).to eq error.code
        expect(serialized[:title]).to eq error.title
        expect(serialized[:detail]).to eq error.detail
        expect(serialized[:meta]).to eq error.meta
      end
    end

    context 'should work with custom values' do
      let(:error) { described_class.new(message, param: param) }
      it do
        serialized = subject
        expect(serialized[:status]).to eq error.status
        expect(serialized[:title]).to eq error.title
        expect(serialized[:detail]).to eq error.detail
        expect(serialized[:meta][:message]).to eq message
        expect(serialized[:meta][:param]).to eq param.to_s.camelize(:lower)
      end
    end
  end
end
