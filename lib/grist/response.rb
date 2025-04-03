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
  end
end
