class Employee < ApplicationRecord
  include Commons::Concerns::Extensions::Deleted
end
