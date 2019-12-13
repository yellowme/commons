module Catalogs
  class ApplicationParameter < ApplicationRecord
    validates :name, :value, presence: true
    validates :name, uniqueness: true
  end
end
