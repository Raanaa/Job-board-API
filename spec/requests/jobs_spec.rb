require 'rails_helper'

RSpec.describe "Jobs", type: :request do
 
# initialize test data 
  let!(:jobs) { create_list(:job, 10) }
  let(:job_id) { jobs.first.id }
  let(:user) { FactoryBot.create(:user, username: 'Rana', password: 'password') }
  let(:admin_user) { FactoryBot.create(:user, username: 'Rana', password: 'password', admin: true) }

  # Test GET /jobs
  describe "GET /jobs", autodoc: true do
    before { get '/api/v1/jobs', headers: { 'Authorization' => AuthenticationTokenService.call(user.id) }}

    it 'returns jobs' do
      #expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

   # Test GET /jobs/:id
  describe 'GET /jobs/:id' , autodoc: true do
    before { get "/api/v1/jobs/#{job_id}", headers: { 'Authorization' => AuthenticationTokenService.call(user.id) } }

    context 'when the record exists' do
      it 'returns the job' do
        #expect(json).not_to be_empty
        expect(json['id']).to eq(job_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:job_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Job with 'id'=100\"}")
      end
    end
  end

   # Test POST /jobs
  describe 'POST /jobs' , autodoc: true do
    let(:valid_attributes) { { title: 'engineer', description: 'lorem', company: 'ABC'} }

    context 'when the request is valid' do
      before { post '/api/v1/jobs', params: valid_attributes , headers: { 'Authorization' => AuthenticationTokenService.call(admin_user.id) }}

      it 'creates a job' do
        expect(json['title']).to eq('engineer')
        expect(json['description']).to eq('lorem')
        expect(json['company']).to eq('ABC')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/jobs', params: { title: 'Foobar', description: 'lorem' },headers: { 'Authorization' => AuthenticationTokenService.call(admin_user.id) } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"company\":[\"can't be blank\"]}")
      end
    end
  end

  # Test PUT /jobs/:id
  describe 'PUT /jobs/:id' , autodoc: true do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/api/v1/jobs/#{job_id}", params: valid_attributes , headers: { 'Authorization' => AuthenticationTokenService.call(admin_user.id) }}

      it 'updates the record' do
        expect(json).not_to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end

  # Test DELETE /jobs/:id
  describe 'DELETE /jobs/:id' , autodoc: true do
    
    context 'when the record deleted' do
      before { delete "/api/v1/jobs/#{job_id}", headers: { 'Authorization' => AuthenticationTokenService.call(admin_user.id) } }

      it 'delete the record' do
        expect(response.body)
          .to match("Job with id = #{job_id} is destroyed")
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end