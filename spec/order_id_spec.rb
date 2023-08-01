RSpec.describe OrderId do
  it "has a version number" do
    expect(OrderId::VERSION).not_to be nil
  end

  it { should respond_to(:generate) }
  it { should respond_to(:get_time) }

  describe '.generate' do
    context 'with defaults' do
      subject { described_class.generate }
      it 'generates a string 22 chars long' do
        expect(subject.length).to eq 22
      end

      it 'contains valid characters' do
        expect(subject).to match(/^[A-Z0-9-]+$/)
      end
    end

    context 'with custom options' do
      subject { described_class.generate(decimal_places: 16, separator: '_') }
      it 'generates a string with custom decimal_places and separator' do
        expect(subject.length).to eq 20 # 17 chars and 3 separators
        expect(subject).to match(/^[A-Z0-9_]+$/)
      end
    end

    context 'with custom separator' do
      let(:separator) { '#' }
      subject { described_class.generate(separator: separator) }

      it 'generates a different ID than the default' do
        default_id = described_class.generate
        expect(subject).not_to eq default_id
      end

      it 'contains the custom separator' do
        expect(subject).to include(separator)
      end
    end

    context 'with invalid separator' do
      it 'raises ArgumentError' do
        expect { described_class.generate(separator: 'A') }.to raise_error(ArgumentError)
      end
    end

    context 'with negative decimal_places' do
      it 'raises FormatError' do
        expect { described_class.generate(decimal_places: -10) }.to raise_error(ArgumentError)
      end
    end

    context 'with invalid decimal_places' do
      it 'raises FormatError' do
        expect { described_class.generate(decimal_places: 'ten') }.to raise_error(ArgumentError)
      end
    end

    context 'with invalid base' do
      it 'raises FormatError when base is not an integer' do
        expect { described_class.generate(base: 'thirty-six') }.to raise_error(ArgumentError)
      end

      it 'raises FormatError when base is out of range' do
        expect { described_class.generate(base: 37) }.to raise_error(ArgumentError)
      end
    end

    context 'with invalid group_length' do
      it 'raises FormatError' do
        expect { described_class.generate(group_length: -5) }.to raise_error(ArgumentError)
      end
    end

    context 'with custom timestamp' do
      let(:timestamp) { Time.new(2022, 12, 25, 0, 0, 0).to_f }
      subject { described_class.generate(timestamp: timestamp) }

      it 'generates a different ID than the default' do
        default_id = described_class.generate
        expect(subject).not_to eq default_id
      end

      it 'generates the same ID for the same timestamp' do
        same_timestamp_id = described_class.generate(timestamp: timestamp)
        expect(subject).to eq same_timestamp_id
      end
    end

    context 'with invalid timestamp' do
      it 'raises ArgumentError' do
        expect { described_class.generate(timestamp: 'invalid') }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.get_time' do
    context 'with defaults' do
      let(:input) { described_class.generate }
      it 'restores a timestamp from an input string' do
        expect(described_class.get_time(input)).to be_a Time
      end
    end
  end
end
