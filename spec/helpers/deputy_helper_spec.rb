require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the DeputyHelper. For example:
#
# describe DeputyHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe 'DeputyHelper', type: :helper do
  context '#set_issuance_date' do
    before :each do
      @date = Time.now
    end

    it 'Should return pt format date' do
      expect(helper.set_issuance_date(issuance_date: @date)).to eq(@date.strftime("%d/%m/%Y"))
    end

    it 'Should return en format date' do
      expect(helper.set_issuance_date(issuance_date: @date, lang: 'en')).to eq(@date.strftime("%Y-%m-%d"))
    end

    context "Should return 'Não Informado'" do
      it 'when date is nil' do
        expect(helper.set_issuance_date(issuance_date: nil)).to eq('Não Informado')
      end

      it 'when language type is not informated' do
        expect(helper.set_issuance_date(issuance_date: @date, lang: '')).to eq('Não Informado')
      end
    end
  end

  context '#set_provider' do
    it 'Should return provider' do
      expect(helper.set_provider(provider: 'any_provider')).to eq('any_provider')
    end

    context "Should return 'Não Informado'" do
      it 'when provider is nil' do
        expect(helper.set_provider(provider: nil)).to eq('Não Informado')
      end

      it 'when provider is empty' do
        expect(helper.set_provider(provider: '')).to eq('Não Informado')
      end
    end
  end

  context '#set_document_url' do
    it 'Should return document url link' do
      expect(helper.set_document_url(document_url: 'any_document_url')).to eq("<a href='any_document_url' target='_blank' class='btn btn-sm btn-primary'><i class='fa fa-download'></i></a>".html_safe)
    end

    context "Should return 'Não Informado'" do
      it 'when document_url is nil' do
        expect(helper.set_document_url(document_url: nil)).to eq('Não Informado')
      end

      it 'when document_url is empty' do
        expect(helper.set_document_url(document_url: '')).to eq('Não Informado')
      end
    end
  end
end
