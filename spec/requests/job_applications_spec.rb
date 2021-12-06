require 'rails_helper'

RSpec.describe "JobApplications", type: :request do
 
# initialize test data 
  let!(:job_applications) { create_list(:job_application, 10) }
  let(:job_application_id) { job_applications.first.id }
  let(:user) { FactoryBot.create(:user, username: 'Rana', password: 'password') }
  let(:admin_user) { FactoryBot.create(:user, username: 'Rana', password: 'password', admin: true) }


  # Test GET /jobs
  describe "GET /job_applications", autodoc: true do
    before { get '/api/v1/job_applications', headers: { 'Authorization' => AuthenticationTokenService.call(admin_user.id) }}

    it 'returns job_applications' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end


   # Test GET /jobs/:id
  describe 'GET /job_applications/:id' , autodoc: true do
    before { get "/api/v1/job_applications/#{job_application_id}", headers: { 'Authorization' => AuthenticationTokenService.call(admin_user.id) } }

    context 'when the record exists' do
      it 'returns the job_application' do
        expect(json['id']).to eq(job_application_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:job_application_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find JobApplication with 'id'=100\"}")
      end
    end
  end

   # Test POST /jobs
  describe 'POST /job_applications' , autodoc: true do
    let!(:job) { create(:job) }
    let(:job_id) { job.id }
    let(:valid_attributes) { { job_id: job_id} }

    context 'when the request is valid' do
      before { post '/api/v1/job_applications', params: valid_attributes , headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }}

      it 'creates a job' do
        expect(json['status']).to eq('not_seen')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/job_applications',headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"job\":[\"must exist\"]}")
      end
    end
  end
end