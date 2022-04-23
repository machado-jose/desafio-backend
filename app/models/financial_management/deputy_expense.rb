require './app/services/infrastructure/validator.rb'

class FinancialManagement::DeputyExpense < ApplicationRecord
  belongs_to :legislature

  enum document_type: {
    invoice: 0,
    receipt: 1,
    expense_abroad: 2
  }

  def custom_initialize(legislature:, sub_quota_number:, sub_quota_description:, sub_quota_specification_number:, 
                        sub_quota_specification_description:, provider:, provider_registration_number:, document_number:,
                        document_type:, issuance_date:, document_value:, reverse_value:, net_value:, competence:,
                        installment_number:, passager:, leg_trip:, batch_number:, reimbursement_number:, refund_value:, applicant_identifier:)
    
    change_legislature(legislature: legislature)
    change_sub_quota_number(sub_quota_number: sub_quota_number)
    change_sub_quota_description(sub_quota_description: sub_quota_description)
    change_sub_quota_specification_number(sub_quota_specification_number: sub_quota_specification_number)
    change_sub_quota_specification_description(sub_quota_specification_description: sub_quota_specification_description)
    change_provider(provider: provider)
    change_provider_registration_number(provider_registration_number: provider_registration_number)
    change_document_number(document_number: document_number)
    change_document_type(document_type: document_type)
    change_issuance_date(issuance_date: issuance_date)
    change_document_value(document_value: document_value)
    change_reverse_value(reverse_value: reverse_value)
    change_net_value(net_value: net_value)
    change_competence(competence: competence)
    change_installment_number(installment_number: installment_number)
    change_passager(passager: passager)
    change_leg_trip(leg_trip: leg_trip)
    change_batch_number(batch_number: batch_number)
    change_reimbursement_number(reimbursement_number: reimbursement_number)
    change_refund_value(refund_value: refund_value)
    change_applicant_identifier(applicant_identifier: applicant_identifier)
  end

  private
  def change_legislature(legislature:)
    Validator.assert_object_class_type legislature, Legislature
    self.legislature = legislature
    self
  end

  def change_sub_quota_number(sub_quota_number:)
    Validator.assert_empty_string sub_quota_number
    self.sub_quota_number = sub_quota_number
    self
  end

  def change_sub_quota_description(sub_quota_description:)
    Validator.assert_empty_string sub_quota_description
    self.sub_quota_description = sub_quota_description
    self
  end

  def change_sub_quota_specification_number(sub_quota_specification_number:)
    Validator.assert_empty_string sub_quota_specification_number
    self.sub_quota_specification_number = sub_quota_specification_number
    self
  end

  def change_sub_quota_specification_description(sub_quota_specification_description:)
    Validator.assert_empty_string sub_quota_specification_description
    self.sub_quota_specification_description = sub_quota_specification_description
    self
  end

  def change_provider(provider:)
    Validator.assert_empty_string provider
    self.provider = provider
    self
  end

  def change_provider_registration_number(provider_registration_number:)
    Validator.assert_empty_string provider_registration_number
    self.provider_registration_number = provider_registration_number
    self
  end

  def change_document_number(document_number:)
    Validator.assert_empty_string document_number
    self.document_number = document_number
    self
  end

  def change_document_type(document_type:)
    Validator.assert_integer_number document_type
    self.document_type = document_type
    self
  end

  def change_issuance_date(issuance_date:)
    Validator.assert_datetime issuance_date
    self.issuance_date = issuance_date
    self
  end

  def change_document_value(document_value:)
    Validator.assert_big_decimal document_value
    self.document_value = document_value
    self
  end

  def change_reverse_value(reverse_value:)
    Validator.assert_big_decimal reverse_value
    self.reverse_value = reverse_value
    self
  end

  def change_net_value(net_value:)
    Validator.assert_big_decimal net_value
    self.net_value = net_value
    self
  end

  def change_competence(competence:)
    Validator.assert_empty_string competence
    self.competence = competence
    self
  end

  def change_installment_number(installment_number:)
    Validator.assert_integer_number installment_number
    self.installment_number = installment_number
    self
  end

  def change_passager(passager:)
    Validator.assert_empty_string passager unless passager.nil?
    self.passager = passager
    self
  end

  def change_leg_trip(leg_trip:)
    Validator.assert_empty_string leg_trip unless passager.nil?
    self.leg_trip = leg_trip
    self
  end

  def change_batch_number(batch_number:)
    Validator.assert_empty_string batch_number
    self.batch_number = batch_number
    self
  end

  def change_reimbursement_number(reimbursement_number:)
    Validator.assert_empty_string reimbursement_number
    self.reimbursement_number = reimbursement_number
    self
  end

  def change_refund_value(refund_value:)
    Validator.assert_big_decimal refund_value
    self.refund_value = refund_value
    self
  end

  def change_applicant_identifier(applicant_identifier:)
    Validator.assert_empty_string applicant_identifier
    self.applicant_identifier = applicant_identifier
    self
  end
end
