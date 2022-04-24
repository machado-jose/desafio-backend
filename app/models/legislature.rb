require './app/services/infrastructure/validator.rb'

class Legislature < ApplicationRecord
  belongs_to :deputy
  has_many :deputy_expenses, class_name: 'FinancialManagement::DeputyExpense', inverse_of: :legislature
  validates :deputy, presence: { strict: true }
  validates :legislature_number, presence: { strict: true }, uniqueness: { strict: true }
  validates :uf, presence: { strict: true }
  validates :party_acronym, presence: { strict: true }
  validates :legislature_code, presence: { strict: true }, uniqueness: { strict: true }
  validates_associated :deputy_expenses, presence: { strict: true }
  after_validation :upcase_legislature_data

  def add_deputy_expense(sub_quota_number:, sub_quota_description:, sub_quota_specification_number:, sub_quota_specification_description:, 
                         provider:, provider_registration_number:, document_number:, document_type:, issuance_date:, document_value:, 
                         reverse_value:, net_value:, competence:, installment_number:, passager:, leg_trip:, batch_number:, 
                         reimbursement_number:, refund_value:, applicant_identifier:)
    unless has_deputy_expense?(document_number: document_number)
      self.deputy_expenses << FinancialManagement::DeputyExpense.new(
                                                                      legislature: self, 
                                                                      sub_quota_number: sub_quota_number, 
                                                                      sub_quota_description: sub_quota_description, 
                                                                      sub_quota_specification_number: sub_quota_specification_number, 
                                                                      sub_quota_specification_description: sub_quota_specification_description, 
                                                                      provider: provider, 
                                                                      provider_registration_number: provider_registration_number, 
                                                                      document_number: document_number,
                                                                      document_type: document_type, 
                                                                      issuance_date: issuance_date, 
                                                                      document_value: document_value, 
                                                                      reverse_value: reverse_value, 
                                                                      net_value: net_value, 
                                                                      competence: competence,
                                                                      installment_number: installment_number, 
                                                                      passager: passager, 
                                                                      leg_trip: leg_trip, 
                                                                      batch_number: batch_number, 
                                                                      reimbursement_number: reimbursement_number, 
                                                                      refund_value: refund_value, 
                                                                      applicant_identifier: applicant_identifier
                                                                    )
    end
  end

  private
  def upcase_legislature_data
    self.party_acronym = self.party_acronym.upcase
    self.uf = self.uf.upcase
  end

  def has_deputy_expense?(document_number:)
    find_deputy_expense(document_number: document_number).present?
  end

  def find_deputy_expense(document_number:)
    self.deputy_expenses.find_by(document_number: document_number)
  end
end
