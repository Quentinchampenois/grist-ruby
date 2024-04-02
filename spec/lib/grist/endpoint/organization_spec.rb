require "spec_helper"

RSpec.describe Grist::Endpoint::Organization do
  subject { grist_client }

  let(:grist_client) { Grist::Client.new }

  describe "#organizations" do
    it "calls the get method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:get).with("/orgs")
      subject.organizations
    end

    context "when the request is successful" do
      let(:orgs) { load_fixture("spec/fixtures/endpoints/organization/list.json") }

      before do
        allow_any_instance_of(Grist::HTTP).to receive(:get).with("/orgs").and_return(orgs)
      end

      it "returns the response" do
        expect(subject.organizations).to eq([
                                     {
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
                                     }
                                   ])
      end
    end
  end

  describe "#organization" do
    let(:id) { 42 }

    it "calls the get method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:get).with("/orgs/42")
      subject.organization(id)
    end

    context "when the request is successful" do
      let(:org) { load_fixture("spec/fixtures/endpoints/organization/find.json") }

      before do
        allow_any_instance_of(Grist::HTTP).to receive(:get).with("/orgs/42").and_return(org)
      end

      it "returns the response" do
        expect(subject.organization(id)).to eq({
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

  describe "#update_organization" do
    let(:id) { 42 }
    let(:body) { { name: "Grist Labs" } }

    it "calls the patch method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:patch).with("/orgs/42", { name: "Grist Labs" })
      subject.update_organization(id, body)
    end
  end

  describe "#list_users_with_access" do
    it "calls the get method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:get).with("/orgs/42/access")
      subject.list_users_with_access(42)
    end
  end

  describe "#manage_access" do
    let(:id) { 42 }
    let(:body) do
      Hash.new(
        "delta" => {
          "users" => [
            "owner@example.org" => "owner",

            "viewer@example.org" => "viewer"
          ]
        }
      )
    end

    it "calls the patch method with the correct path" do
      expect_any_instance_of(Grist::HTTP).to receive(:patch).with("/orgs/42/access", body)

      subject.manage_access(42)
    end
  end
end
