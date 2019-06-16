RSpec.describe 'User Registration', type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  context 'with valid credentials' do
    it 'returns a user and a token' do
      post '/api/v1/auth', params: { email: 'felix@craft.se',
                                     password: 'password',
                                     password_confirmation: 'password'
                                  }, headers: headers

      expect(json_response['status']).to eq 'success'
      expect(response.status).to eq 200
    end
  end

  context 'returns an error when user tries to submit' do
    it 'a non-matching password confirmation' do
      post '/api/v1/auth', params: { email: 'zane@craft.se',
                                     password: 'password',
                                     password_confirmation: 'bad_password'
                                  }, headers: headers

      expect(json_response['errors']['password_confirmation']).to eq ["doesn't match Password"]
      expect(response.status).to eq 422
    end

    it 'an invalid email address' do
      post '/api/v1/auth', params: { email: 'george@craft',
                                     password: 'password',
                                     password_confirmation: 'password'
                                  }, headers: headers

      expect(json_response['errors']['email']).to eq ['is not an email']
      expect(response.status).to eq 422
    end

    it 'an already registered email address' do
      FactoryBot.create(:user, email: 'carla@craft.se',
                               password: 'password',
                               password_confirmation: 'password')

      post '/api/v1/auth', params: { email: 'carla@craft.se',
                                     password: 'password',
                                     password_confirmation: 'password'
                                  }, headers: headers

      expect(json_response['errors']['email']).to eq ['has already been taken']
      expect(response.status).to eq 422
    end
  end
end 