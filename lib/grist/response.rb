# frozen_string_literal: true

module Grist
  class Response
    attr_reader :data, :error, :code, :type

    def initialize(data: nil, error: nil, code: nil, type: nil)
      @data = data
      @error = error
      @type = type
      @code = code&.to_i
    end

    def success?
      error.nil? && (@code >= 200 && @code < 400)
    end

    def error?
      !error.nil? || !(@code >= 200 && @code < 400)
    end

    def not_found?
      @code == 404
    end

    def print_error
      err = "#{@type}: #{@error}"
      err += " (code: #{@code})" if @code
      err += "\n#{@type.help}" if @type.respond_to?(:help) && !@type.help.nil?
      err
    end

    def log_error
      return unless error?

      Grist.logger.error("Grist API Error: #{@type} (code: #{@code})- #{@error}")
    end
  end
end
