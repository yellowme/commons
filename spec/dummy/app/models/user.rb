class User < ApplicationRecord
  include Bestie::Concerns::Guard::Capitalizable
  include Bestie::Concerns::Validations::Undestroyable

  capitalize only: [:name]

  strip_attributes only: [:name, :last_name],
                   allow_empty: true,
                   collapse_spaces: true

  validates :name,
            :last_name,
            presence: true
end
