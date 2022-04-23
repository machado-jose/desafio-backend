require 'rails_helper'
require './app/services/infrastructure/validator.rb'

describe 'Validator' do
  context 'Should raise an error' do
    it 'Invalid object' do
      expect {
        Validator.assert_object_class_type 30, String
      }.to raise_error(ArgumentError)
    end

    it 'Empty String' do
      expect{
        Validator.assert_object_class_type ''
      }.to raise_error(ArgumentError)
    end

    it 'Is not Integer' do
      expect{
        Validator.assert_integer_number 3.0
      }.to raise_error(ArgumentError)
    end

    it 'Is not BigDecimal' do
      expect{
        Validator.assert_big_decimal 3.0
      }.to raise_error(ArgumentError)
    end

    it 'Is not DateTime' do
      expect{
        Validator.assert_datetime "2022-04-23T19:59:55-03:00"
      }.to raise_error(ArgumentError)
    end
  end
end
