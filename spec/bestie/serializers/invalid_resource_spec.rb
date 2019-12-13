RSpec.describe Bestie::Errors::InvalidResource, type: :serializer do
  let(:title) { Faker::Name.name }
  let(:message) { Faker::Name.name }
  let(:detail) { Faker::Name.name }
  let(:validation_errors) { { data: Faker::Name.name } }
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
      let(:error) { described_class.new(message, title: title, detail: detail, validation_errors: validation_errors) }
      it do
        serialized = subject
        expect(serialized[:status]).to eq error.status
        expect(serialized[:title]).to eq title
        expect(serialized[:detail]).to eq detail
        expect(serialized[:meta][:message]).to eq message
        expect(serialized[:meta][:validation_errors]).to eq validation_errors
      end
    end
  end
end
