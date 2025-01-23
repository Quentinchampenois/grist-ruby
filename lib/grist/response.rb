module Grist
  class Response
    attr_reader :data, :error, :code

    def initialize(data: nil, error: nil, code: nil)
      @data = data
      @error = error
      @code = code
    end

    def success?
      error.nil?
    end
  end
end