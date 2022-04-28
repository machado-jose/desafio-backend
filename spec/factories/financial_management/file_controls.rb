FactoryBot.define do
  factory :file_control, class: 'FinancialManagement::FileControl' do
    expense_year { DateTime.now.year.to_s }
  end
end
