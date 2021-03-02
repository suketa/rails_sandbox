class User < ApplicationRecord
  has_secure_password :mfa_code, validations: false
end
