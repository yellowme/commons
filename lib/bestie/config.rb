module Bestie
  class << self
    def secret_key_base=(secret_key_base)
      @secret_key_base = secret_key_base
    end

    def secret_key_base
      @secret_key_base || ENV["secret_key_base"]
    end
  end
end
