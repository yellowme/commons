require 'commons/railtie'

require 'strip_attributes'
require 'active_model_serializers'
require 'jwt'

require 'commons/config'

# authentication
require 'commons/authentication/json_web_token'
require 'commons/authentication/authenticate_by_jwt'

# controllers
require 'commons/controllers/schema_validable'

# repositories
require 'commons/repositories/base_repository'
require 'commons/repositories/catalogs/concerns/model_caching_extention'
require 'commons/repositories/catalogs/base_catalog'

# services
require 'commons/services/concerns/callable'

# models
require 'commons/concerns/guard/capitalizable'
require 'commons/concerns/validations/undestroyable'

# utils
require 'commons/formatter/null_attributes_remover'
require 'commons/formatter/regex_constants'
require 'commons/formatter/string_utils'

# errors
require 'commons/errors/error_base'
require 'commons/errors/error_serializer'
require 'commons/errors/bad_request'
require 'commons/errors/conflict'
require 'commons/errors/default_handling'
require 'commons/errors/forbidden'
require 'commons/errors/internal_server_error'
require 'commons/errors/unprocessable_entity'
require 'commons/errors/invalid_resource'
require 'commons/errors/maintenance_mode'
require 'commons/errors/missing_parameter'
require 'commons/errors/not_unique'
require 'commons/errors/payment_required'
require 'commons/errors/precondition_failed'
require 'commons/errors/route_not_found'
require 'commons/errors/unauthorized'

# middleware
require 'commons/middleware/catch_json_parse_errors'

I18n.load_path += Dir[Rails.root.join('commons', 'locales', '**/*.yml').to_s]
I18n.reload! if I18n.backend.initialized?

module Commons
end
