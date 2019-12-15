module Commons
  module Middleware
    class CatchJsonParseErrors
      def initialize(app)
        @app = app
      end

      def call(env)
        @app.call(env)
      rescue ActionDispatch::Http::Parameters::ParseError => e
        if env['HTTP_ACCEPT'] =~ %r{application/json} ||
           env['CONTENT_TYPE'] =~ %r{application/json}
          str = Commons::Errors::ErrorSerializer.new(Commons::Errors::BadRequest.new(e)).to_json
          str.tr!("'", '\'')
          return [
            '400',
            { 'Content-Type' => 'application/json' },
            [
              '{ "error":'\
              "#{str}"\
              '}'\
            ]
          ]
        else
          raise e
        end
      end
    end
  end
end
