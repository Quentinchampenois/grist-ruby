require "spec_helper"

RSpec.describe Grist::Client do
  subject { described_class.new(url: url, token: token) }

  let(:url) { "http://example.org" }
  let(:token) { "12345-67890-abcde-12345-67890" }

  it "defines a url" do
    expect(subject.instance_variable_get(:@url)).to eq(url)
  end

  it "defines a token" do
    expect(subject.instance_variable_get(:@token)).to eq(token)
  end

  describe "#connection" do
    it "returns a connection" do
      expect(subject.connection).to be_a(Faraday::Connection)
    end

    it "has Authentication middleware" do
      expect(subject.connection.builder.handlers).to include(Faraday::Request::Authorization)
    end
  end
end
