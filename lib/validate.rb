module Validate
  def key_valid?(key)
    return false unless key.is_a? String
    key.length == 5
  end

  def date_valid?(date)
    return false unless date.is_a? String

    date_array = date.scan(/../)
    Date.valid_date?(date_array[2].to_i, date_array[1].to_i, date_array[0].to_i)
  end

  def error_message
    "ERROR: Either the key or date entered is invalid.
       Please enter a 5 digit number for the key and a valid date in this format DDMMYY"
  end
end