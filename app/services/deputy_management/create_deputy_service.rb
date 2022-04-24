class CreateDeputyService
  def initialize(name:, ide_register:, deputy_wallet_number:)
    @name = name
    @ide_register = ide_register
    @deputy_wallet_number = deputy_wallet_number
  end

  def call
    deputy = Deputy.new(
      name: @name, 
      ide_register: @ide_register, 
      deputy_wallet_number: @deputy_wallet_number
    )
    deputy.valid?
    deputy.save!
    deputy
  end
end
