RSpec.describe Api::V1::PostsController, type: :request do
  let(:user) { FactoryBot.create(:user, email: 'george@mail.com') }
  let(:admin) { FactoryBot.create(:user, admin: true, email: 'noel@craft.com') }
  let(:post) { FactoryBot.create(:post) }
  let(:credentials) { user.create_new_auth_token }
  let(:admin_credentials) { admin.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: "application/json" }.merge!(credentials) }
  let(:admin_headers) { { HTTP_ACCEPT: "application/json" }.merge!(admin_credentials) }

  describe "DELETE /api/v1/posts/id" do

    it "deletes a post if user is admin" do
      delete "/api/v1/posts/#{post.id}", headers: admin_headers
      expect(response.status).to eq 200
      expect(json_response['message']).to eq 'Post successfully deleted'
    end

    it "does not delete post if user does not have admin privileges" do
      delete "/api/v1/posts/#{post.id}", headers: headers
      post.reload
      expect(response.status).to eq 422
      expect(json_response['error']).to eq 'You do not have sufficient privileges to perform this action'
    end
  end
end