class CreateDeputyService
  def call(name:, ide_register:, deputy_wallet_number:)
    deputy = Deputy.new(
      name: name, 
      ide_register: ide_register, 
      deputy_wallet_number: deputy_wallet_number
    )
    deputy.valid?
    deputy.save!
    deputy
  end
end
