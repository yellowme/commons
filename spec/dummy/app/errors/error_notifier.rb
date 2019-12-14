module ErrorNotifier
  private

  # :nocov:
  def print_trace(e)
    return if Rails.env.test? || e.nil?

    puts e.message unless e.message.nil?
    puts e.backtrace unless e.backtrace.nil?
  end
  # :nocov:
end
