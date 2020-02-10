class User < ApplicationRecord
  include Commons::Concerns::Attributes::Sex
  include Commons::Concerns::Extensions::SoftDeleted
  include Commons::Concerns::Guard::Capitalizable
  include Commons::Concerns::Validations::Undestroyable

  capitalize only: [:name]

  strip_attributes only: [:name, :last_name],
                   allow_empty: true,
                   collapse_spaces: true

  validates :name,
            :last_name,
            presence: true
end
