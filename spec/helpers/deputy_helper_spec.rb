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
end
