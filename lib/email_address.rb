class EmailAddress
  VALID_EMAIL_ADDRESS_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  def self.malformed?(email)
    !valid?(email)
  end

  def self.valid?(email)
    email =~ VALID_EMAIL_ADDRESS_REGEX
  end
end
