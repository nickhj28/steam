require 'spec_helper'

describe Locomotive::Steam::TranslatorService do

  let(:default_locale)  { 'en' }
  let(:repository)      { instance_double('Repository') }
  let(:service)         { described_class.new(repository, default_locale) }

  describe '#translate' do

    let(:input)   { 'example_test' }
    let(:locale)  { nil }
    let(:scope)   { nil }

    subject { service.translate(input, locale, scope) }

    describe 'existing translation' do

      let(:translation) { instance_double('Translation', values: { 'en' => 'Example text', 'es' => 'Texto de ejemplo' }) }

      before do
        allow(repository).to receive(:by_key).with('example_test').and_return(translation)
      end

      it { is_expected.to eq 'Example text' }

      context 'no translation found' do

        let(:translation) { nil }
        it { is_expected.to eq 'example_test' }

      end

      context 'specifying a locale' do

        let(:locale) { 'es' }
        it { is_expected.to eq 'Texto de ejemplo' }

      end

      context "specifying a locale that doesn't exist" do

        let(:locale) { 'nl' }

        it 'reverts to default locale' do
          is_expected.to eq "example_test"
        end

      end

      context "specifying a scope" do

        let(:input)   { 'fr' }
        let(:locale)  { 'en' }
        let(:scope)   { 'locomotive.locales' }

        it { is_expected.to eq 'French' }

      end

    end

  end

end
