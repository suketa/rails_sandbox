class User < ApplicationRecord
  def to_param
    "#{id}-#{name.parameterize(locale: :de)}"
    # "#{id}-#{name.parameterize}"
  end
end
