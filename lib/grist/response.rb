module Grist
  class Response
    attr_reader :data, :error, :code

    def initialize(data: nil, error: nil, code: nil)
      @data = data
      @error = error
      @code = code&.to_i
    end

    def success?
      error.nil? && (@code >= 200 && @code < 400)
    end
  end
end