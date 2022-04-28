class CreateFileControlService
  def initialize(expense_year:)
    @expense_year = expense_year
  end

  def call
    return false if FinancialManagement::FileControl.find_by(expense_year: @expense_year).present?
    begin
      FinancialManagement::FileControl.create!(
        expense_year: @expense_year
      )
      return true
    rescue => e
      return false
    end
  end
end
