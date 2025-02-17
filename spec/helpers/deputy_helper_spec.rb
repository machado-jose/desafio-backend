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

  context '#set_chart_labels' do
    it 'Should return expense months' do
      deputy_expense = create(:deputy_expense, expense_month: '3', expense_year: '2021')
      deputy = deputy_expense.legislature.deputy
      deputy.reload
      expenses_by_month = deputy.expenses_for_every_month_of_year(year: '2021')
      expect(helper.set_chart_labels(expenses_by_month: expenses_by_month)).to eq(["Março"].to_json)
    end

    context 'Should return empty' do
      it 'when expenses_by_month is empty' do
        expect(helper.set_chart_labels(expenses_by_month: [])).to eq([].to_json)
      end

      it 'when expenses_by_month is nil' do
        expect(helper.set_chart_labels(expenses_by_month: nil)).to eq([].to_json)
      end
    end
  end

  context '#set_chart_data' do
    it 'Should return expense months' do
      deputy_expense = create(:deputy_expense, expense_month: '3', expense_year: '2021', net_value: 60.0)
      deputy = deputy_expense.legislature.deputy
      deputy.reload
      expenses_by_month = deputy.expenses_for_every_month_of_year(year: '2021')
      expect(helper.set_chart_data(expenses_by_month: expenses_by_month)).to eq([60.0].to_json)
    end

    context 'Should return empty' do
      it 'when expenses_by_month is empty' do
        expect(helper.set_chart_data(expenses_by_month: [])).to eq([].to_json)
      end

      it 'when expenses_by_month is nil' do
        expect(helper.set_chart_data(expenses_by_month: nil)).to eq([].to_json)
      end
    end
  end

  context '#translate_months' do
    context 'Should months to pt language' do
      it 'January' do
        expect(helper.translate_months(month_to_translate: 'January')).to eq('Janeiro')
      end

      it 'February' do
        expect(helper.translate_months(month_to_translate: 'February')).to eq('Fevereiro')
      end

      it 'March' do
        expect(helper.translate_months(month_to_translate: 'March')).to eq('Março')
      end

      it 'April' do
        expect(helper.translate_months(month_to_translate: 'April')).to eq('Abril')
      end

      it 'May' do
        expect(helper.translate_months(month_to_translate: 'May')).to eq('Maio')
      end

      it 'June' do
        expect(helper.translate_months(month_to_translate: 'June')).to eq('Junho')
      end

      it 'July' do
        expect(helper.translate_months(month_to_translate: 'July')).to eq('Julho')
      end

      it 'August' do
        expect(helper.translate_months(month_to_translate: 'August')).to eq('Agosto')
      end

      it 'September' do
        expect(helper.translate_months(month_to_translate: 'September')).to eq('Setembro')
      end

      it 'October' do
        expect(helper.translate_months(month_to_translate: 'October')).to eq('Outubro')
      end

      it 'November' do
        expect(helper.translate_months(month_to_translate: 'November')).to eq('Novembro')
      end

      it 'December' do
        expect(helper.translate_months(month_to_translate: 'December')).to eq('Dezembro')
      end
    end

    context 'Should return empty' do
      it 'when passing invalid month' do
        expect(helper.translate_months(month_to_translate: 'other_string')).to eq('')
      end

      it 'when passing nil' do
        expect(helper.translate_months(month_to_translate: nil)).to eq('')
      end
    end
  end
end
