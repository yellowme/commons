describe Commons::Errors::Conflict do
  describe 'handle_error' do
    context 'works with no message or validation_errors' do
      it do
        expect do
          raise described_class
        end.to raise_error(described_class)
      end
    end

    context 'default values works ok' do
      subject { described_class.new }

      it do
        expect do
          raise subject
        end.to raise_error(described_class)
      end
      it { expect(subject.detail).to eq I18n.t('status_code.IER4004_conflict.detail') }
    end

    context 'works with message but no validation_errors' do
      let(:message) { 'my totally non-existent message' }

      subject { described_class.new(message) }

      it do
        expect do
          raise subject
        end.to raise_error(described_class)
      end
      it { expect(subject.message).to eq message }
    end

    context 'works with message & validation_errors' do
      let(:message) { 'my totally non-existent message' }
      let(:detail) { { errors: 'my totally non-existent error' } }

      subject { described_class.new(message, nil, detail: detail) }

      it do
        expect do
          raise subject
        end.to raise_error(described_class)
      end
      it { expect(subject.detail).to eq detail }
    end

    context 'works with message & backtrace' do
      let(:message) { 'my totally non-existent message' }

      subject { described_class.new(message, [message]) }

      it do
        expect do
          raise subject
        end.to raise_error(described_class)
      end
      it { expect(subject.backtrace).to eq [message] }
    end
  end
end
