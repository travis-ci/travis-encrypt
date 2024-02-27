# frozen_string_literal: true

describe Travis::Encrypt do
  include described_class::Helpers

  let(:string)    { 'travis' }
  let(:encrypted) { encrypt(string, options) }
  let(:decrypted) { decrypt(encrypted, options) }
  let(:options)   { { key: 'secret' * 10 } }

  it 'can decrypt an encrypted string' do
    expect(decrypted).to eql(string)
  end

  it 'prefixes the encrypted string by default' do
    expect(encrypted[0..7]).to eql(Travis::Encrypt::PREFIX)
  end

  it 'does not prefix the encrypted string when opted out' do
    options[:use_prefix] = false
    expect(encrypted[0..7]).not_to eql(described_class::PREFIX)
  end

  describe 'travis-core legacy compat' do
    let(:encrypted) { '--ENCR--q/BkAx83j9FaMqw0RR2mqzBmMjI1ZGFjMGI3YTY3ZDc=' }

    it { expect(decrypted).to eq('foo') }
  end
end
