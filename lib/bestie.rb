require 'bestie/railtie'

require 'strip_attributes'
require 'active_model_serializers'
require 'jwt'

require 'bestie/config'

# authentication
require 'bestie/authentication/json_web_token'
require 'bestie/authentication/authenticate_by_jwt'

# repositories
require 'bestie/repositories/base_repository'
require 'bestie/repositories/catalogs/concerns/model_caching_extention'
require 'bestie/repositories/catalogs/base_catalog'

# services
require 'bestie/services/concerns/callable'

# models
require 'bestie/concerns/guard/capitalizable'
require 'bestie/concerns/validations/undestroyable'

# utils
require 'bestie/formatter/null_attributes_remover'
require 'bestie/formatter/regex_constants'
require 'bestie/formatter/string_utils'

# errors
require 'bestie/errors/error_base'
require 'bestie/errors/error_serializer'
require 'bestie/errors/bad_request'
require 'bestie/errors/conflict'
require 'bestie/errors/default_handling'
require 'bestie/errors/forbidden'
require 'bestie/errors/internal_server_error'
require 'bestie/errors/unprocessable_entity'
require 'bestie/errors/invalid_resource'
require 'bestie/errors/maintenance_mode'
require 'bestie/errors/missing_parameter'
require 'bestie/errors/not_unique'
require 'bestie/errors/payment_required'
require 'bestie/errors/precondition_failed'
require 'bestie/errors/route_not_found'
require 'bestie/errors/unauthorized'

# middleware
require 'bestie/middleware/catch_json_parse_errors'

mydir = __dir__

I18n.load_path += Dir[File.join(mydir, 'bestie', 'locales', '**/*.yml')]
I18n.reload! if I18n.backend.initialized?

module Bestie
end
