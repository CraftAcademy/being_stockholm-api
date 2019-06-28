RSpec.describe Api::V1::PostsController, type: :request do
  let(:user) { FactoryBot.create(:user, email: 'george@mail.com') }
  let(:user2) { FactoryBot.create(:user, email: 'zane@mail.com') }
  let(:admin) { FactoryBot.create(:user, admin: true, email: 'noel@craft.com') }
  let(:post) { FactoryBot.create(:post) }
  let(:post_user) { FactoryBot.create(:post, user_id: user.id) }
  let(:post_user2) { FactoryBot.create(:post, user_id: user2.id) }
  let(:credentials) { user.create_new_auth_token }
  let(:admin_credentials) { admin.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: "application/json" }.merge!(credentials) }
  let(:admin_headers) { { HTTP_ACCEPT: "application/json" }.merge!(admin_credentials) }
  let(:headers_no_auth) { { HTTP_ACCEPT: "application/json" } }

  describe "DELETE /api/v1/posts/id" do

    it "deletes any post if user is admin" do
      delete "/api/v1/posts/#{post.id}", headers: admin_headers
      expect(response.status).to eq 200
      expect(json_response['message']).to eq 'Post successfully deleted'

      delete "/api/v1/posts/#{post_user.id}", headers: admin_headers
      expect(response.status).to eq 200
      expect(json_response['message']).to eq 'Post successfully deleted'

      delete "/api/v1/posts/#{post_user2.id}", headers: admin_headers
      expect(response.status).to eq 200
      expect(json_response['message']).to eq 'Post successfully deleted'
    end

    it "does not delete any posts if user does not have admin privileges" do
      delete "/api/v1/posts/#{post.id}", headers: headers
      expect(response.status).to eq 422
      expect(json_response['error']).to eq 'You do not have sufficient privileges to perform this action or the post you are trying to delete does not exist'
    end

    it "does not delete any posts if user is not authenticated" do
      delete "/api/v1/posts/#{post.id}", headers: headers_no_auth
      expect(response.status).to eq 401
      expect(json_response['errors']).to eq ['You need to sign in or sign up before continuing.']
    end

    it "does delete posts the user has created" do
      delete "/api/v1/posts/#{post_user.id}", headers: headers
      expect(response.status).to eq 200
      expect(json_response['message']).to eq 'You have successfully deleted your post'
    end

    it "does not delete posts another user has created" do
      delete "/api/v1/posts/#{post_user2.id}", headers: headers
      expect(response.status).to eq 422
      expect(json_response['error']).to eq 'You do not have sufficient privileges to perform this action or the post you are trying to delete does not exist'
    end
  end
end