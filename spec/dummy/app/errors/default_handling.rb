# :nocov:
module DefaultHandling
  def self.included(cls)
    cls.class_eval do
      include ErrorNotifier

      # must go first in order to preserve last priority
      # https://stackoverflow.com/a/9121054/3287738
      rescue_from StandardError do |e|
        report_error(e)
        respond Bestie::Errors::InternalServerError.new
      end

      rescue_from Bestie::Errors::ErrorBase do |e|
        if e.instance_of?(Bestie::Errors::InternalServerError) ||
           e.is_a?(Bestie::Errors::InternalServerError) ||
           Rails.env.development?
          report_error(e)
        end
        respond e
      end
    end
  end

  def respond(error)
    render json: [error],
           status: error.status,
           each_serializer: Bestie::Errors::ErrorSerializer
  end

  def report_error(param)
    print_trace(param)
  end
end
# :nocov:
