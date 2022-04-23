class Validator
  def self.assert_empty_string string
    self.assert_object_class_type string, String
    raise ArgumentError.new "Empty string" if string.empty?
  end

  def self.assert_integer_number number 
    self.assert_object_class_type number, Integer
  end

  def self.assert_datetime datetime 
    self.assert_object_class_type datetime, DateTime
  end

  def self.assert_big_decimal big_decimal 
    self.assert_object_class_type big_decimal, BigDecimal
  end

  def self.assert_object_class_type object, class_type
    raise ArgumentError.new "Object is not #{class_type} class" unless object.instance_of? class_type
  end
end
