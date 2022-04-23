class Validator
  def self.assert_empty_string string
    self.assert_object_class_type string, String
    raise ArgumentError "Empty string" if string.empty?
  end

  def self.assert_object_class_type object, class_type
    raise ArgumentError.new("Object is not #{class_type} class") unless object.instance_of? class_type
  end
end
