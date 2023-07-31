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

    context 'with invalid separator' do
      it 'raises FormatError' do
        expect { described_class.generate(separator: 'A') }.to raise_error(OrderId::FormatError)
      end
    end

    context 'with negative decimal_places' do
      it 'raises FormatError' do
        expect { described_class.generate(decimal_places: -10) }.to raise_error(OrderId::FormatError)
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
