describe Travis::Encrypt::Helpers do
  subject { const.new }
  before  { Travis::Encrypt.key = 'abcd' * 8 }

  shared_examples_for 'attributes' do
    it 'encrypts an attribute' do
      subject.attr = 'bar'
      expect(subject.to_h.values.first[0..7]).to eql(Travis::Encrypt::PREFIX)
    end

    it 'decrypts an encrypted attribute' do
      subject.attr = 'bar'
      expect(subject.attr).to eql('bar')
    end
  end

  describe described_class::ActiveRecord do
    let(:const) do
      Struct.new(:attr) do
        include Travis::Encrypt::Helpers::ActiveRecord
        attr_encrypted :attr
      end
    end

    include_examples 'attributes'
  end

  describe described_class::Sequel do
    let(:const) do
      Struct.new(:attr) do
        # Sequel's values method returns a hash of attributes
        include Module.new { def values; to_h; end }
        include Travis::Encrypt::Helpers::Sequel
        attr_encrypted :attr
      end
    end

    include_examples 'attributes'

    it 'decrypts an encrypted value' do
      subject.attr = 'bar'
      expect(subject.values).to eql(attr: 'bar')
    end
  end
end
