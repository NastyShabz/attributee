# frozen_string_literal: true

RSpec.describe Attributee::Attribute do
  describe 'class' do
    subject { described_class }

    describe '.new' do
      context 'when good args' do
        it 'returns new attribute' do
          expect(subject.new :name, nil).to be_instance_of described_class
          expect(subject.new :name, 'James').to be_instance_of described_class
        end
      end

      context 'when bad args' do
        it 'raises ArgumentError' do
          expect { subject.new }.to raise_error(ArgumentError).with_message(/\Awrong number of arguments/)
          expect { subject.new nil }.to raise_error(ArgumentError).with_message(/\Awrong number of arguments/)
          expect { subject.new(nil, nil) }.to raise_error(ArgumentError).with_message("'name' should be a symbol")
          expect { subject.new('name', nil) }.to raise_error(ArgumentError).with_message("'name' should be a symbol")
        end
      end
    end
  end

  describe 'instance' do
    subject { described_class.new :count, nil }

    describe '#changed?' do
      context 'when changed' do
        it 'returns true' do
          subject.value = 1
          expect(subject.changed?).to be true
        end
      end

      context 'when not changed' do
        it 'returns false' do
          expect(subject.changed?).to be false
        end
      end
    end

    describe '#change' do
      context 'when changed' do
        it 'returns diff' do
          subject.value = 1
          expect(subject.change).to eq({old: nil, new: 1})
        end
      end

      context 'when not changed' do
        it 'returns nil' do
          expect(subject.change).to be_nil
        end
      end
    end
  end
end
