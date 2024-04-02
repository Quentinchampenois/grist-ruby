require "spec_helper"

RSpec.describe Grist::Endpoint::Organization do
  subject { grist_client }

  let(:grist_client) { Grist::Client.new }

  describe "#list" do
    it "calls the get method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:get).with("/orgs")
      subject.list
    end

    context "when the request is successful" do
      let(:orgs) { load_fixture("spec/fixtures/endpoints/organization/list.json") }

      before do
        allow_any_instance_of(Grist::HTTP).to receive(:get).with("/orgs").and_return(orgs)
      end

      it "returns the response" do
        expect(subject.list).to eq([
                                               {
                                                 "id" => 42,
                                                 "name" => "Grist Labs",
                                                 "domain" => "gristlabs",
                                                 "owner" => {
                                                   "id" => 101,
                                                   "name" => "Helga Hufflepuff",
                                                   "picture" => "null",
                                                 },
                                                 "access" => "owners",
                                                 "createdAt" => "2019-09-13T15:42:35.000Z",
                                                 "updatedAt" => "2019-09-13T15:42:35.000Z"
                                               }
                                             ])
      end
    end
  end

  describe "#find" do
    let(:id) { 42 }

    it "calls the get method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:get).with("/orgs/42")
      subject.find(id)
    end

    context "when the request is successful" do
      let(:org) { load_fixture("spec/fixtures/endpoints/organization/find.json") }

      before do
        allow_any_instance_of(Grist::HTTP).to receive(:get).with("/orgs/42").and_return(org)
      end

      it "returns the response" do
        expect(subject.find(id)).to eq({
                                         "id" => 42,
                                         "name" => "Grist Labs",
                                         "domain" => "gristlabs",
                                         "owner" => {
                                           "id" => 101,
                                           "name" => "Helga Hufflepuff",
                                           "picture" => "null"
                                         },
                                         "access" => "owners",
                                         "createdAt" => "2019-09-13T15:42:35.000Z",
                                         "updatedAt" => "2019-09-13T15:42:35.000Z"
                                       })
      end
    end
  end
end