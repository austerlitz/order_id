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
    end
  end
  describe '.get_time' do
    context 'with defaults' do
      let(:input) {described_class.generate}
      it 'restores a timestamp from an input string' do
        expect(described_class.get_time(input)).to be_a Time
      end
    end
  end
end
