class Employee < ApplicationRecord
  include Commons::Concerns::Extensions::SoftDeleted
end
