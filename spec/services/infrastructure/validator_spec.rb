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
  end
end
