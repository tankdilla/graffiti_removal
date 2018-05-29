module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from SODA::BadRequest do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ArgumentError do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end
end
