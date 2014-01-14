require 'spec_helper'
require 'json'

describe "Topic API" do
  describe "POST topic" do
    context "with valid params" do

      let(:params) do
        {
          topic: {
            title: "A test topic",
            description: "Just a test topic"
          }
        }
      end

      context "without an API Key" do

        it "has a 401 status code" do
          post "http://conduct.dev/api/v1/topics", params, headers
          expect(response.status).to eq(401)
        end
      
      end

      context "without a valid API Key" do
        
        let(:headers) do
          { 'X-API-Key' => 'donkeykong' }
        end

        it "has a 401 status code" do
          post "http://conduct.dev/api/v1/topics", params, headers
          expect(response.status).to eq(401)
        end

      end

      context "with a valid API Key" do

        let(:headers) do
          { 'X-API-Key' => User.first.access_token }
        end

        it "has a 201 status code" do
          post "http://conduct.dev/api/v1/topics", params, headers
          expect(response.status).to eq(201)
        end

        it "creates a new topic" do
          expect {
            post "http://conduct.dev/api/v1/topics", params, headers
          }.to change{ Topic.count }.by(1)
        end

      end
    end
  end

  describe "GET topics" do
    context "without an API Key" do

      let(:headers) do
        { 'X-API-Key' => 'donkeykong' }
      end

      it "has a 401 status code" do
        get "http://conduct.dev/api/v1/topics", nil, headers
        expect(response.status).to eq(401)
      end
    
    end

    context "with a valid API Key" do
    
      let(:headers) do
        { 'X-API-Key' => User.first.access_token }
      end

      it "has a 201 status code" do
        get "http://conduct.dev/api/v1/topics", nil, headers
        expect(response.status).to eq(200)
      end

      it "only has topics belonging to the user" do
        get "http://conduct.dev/api/v1/topics", nil, headers

        for topic in JSON.parse(response.body) do
          expect(topic["user_id"]).to eq(User.first.id)
        end
      end

      context "given a per_page parameter" do

        let(:params) do { per_page: 2 } end

        it "has exactly or less topics per request than the per_page parameter" do
          get "http://conduct.dev/api/v1/topics", params, headers
          expect(JSON.parse(response.body).count).to <= 1
        end

      end

      context "given a per_page param that is a string" do

        let(:params) do { per_page: "220" } end

        it "has a 400 status code" do
          get "http://conduct.dev/api/v1/topics", params, headers
          expect(response.status).to eq(400)
        end

        it "has an appropriate error" do
          get "http://conduct.dev/api/v1/topics", params, headers
          expect(response.body).to include("Parameter per_page is not an integer")
        end

      end

      context "given a per_page param that is out of range" do

        let(:params) do { per_page: 50000 } end

        it "has a 400 status code" do
          get "http://conduct.dev/api/v1/topics", params, headers
          expect(response.status).to eq(400)
        end

        it "has an appropriate error" do
          get "http://conduct.dev/api/v1/topics", params, headers
          expect(response.body).to include("Parameter per_page is out of range")
        end

      end

      context "not given a per_page param" do

        it "has exactly or less topics per request than the default per_page parameter" do
          get "http://conduct.dev/api/v1/topics", params, headers
          expect(JSON.parse(response.body).count).to <= 20
        end

      end

    end
  end
end
