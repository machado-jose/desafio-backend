class AddExpenseService
  def call(deputy:, legislature_code:, sub_quota_number:, sub_quota_description:, sub_quota_specification_number:, 
            sub_quota_specification_description:, provider:, provider_registration_number:, document_number:, 
            document_type:, issuance_date:, document_value:, reverse_value:, net_value:, expense_month:, 
            expense_year:, installment_number:, passager:, leg_trip:, batch_number:, reimbursement_number:, 
            refund_value:, applicant_identifier:, document_url:)
    legislature = deputy.find_legislature(legislature_code: legislature_code)
    raise ArgumentError.new "Not found Legislature" unless legislature.present?
    legislature.add_deputy_expense(
      sub_quota_number: sub_quota_number, 
      sub_quota_description: sub_quota_description, 
      sub_quota_specification_number: sub_quota_specification_number, 
      sub_quota_specification_description: sub_quota_specification_description, 
      provider: provider, 
      provider_registration_number: provider_registration_number, 
      document_number: document_number, 
      document_type: document_type.to_i, 
      issuance_date: issuance_date.to_date, 
      document_value: document_value, 
      reverse_value: reverse_value.to_d, 
      net_value: net_value.to_d, 
      expense_month: expense_month, 
      expense_year: expense_year, 
      installment_number: installment_number, 
      passager: passager, 
      leg_trip: leg_trip, 
      batch_number: batch_number, 
      reimbursement_number: reimbursement_number, 
      refund_value: refund_value, 
      applicant_identifier: applicant_identifier,
      document_url: document_url
    )
    legislature.save!
    legislature
  end
end
