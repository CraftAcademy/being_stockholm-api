RSpec.describe Api::V1::PostsController, type: :request do
  let(:user) { FactoryBot.create(:user, email: 'george@mail.com') }
  let(:admin) { FactoryBot.create(:user, admin: true, email: 'noel@craft.com') }
  let(:post) { FactoryBot.create(:post) }
  let(:credentials) { user.create_new_auth_token }
  let(:admin_credentials) { admin.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: "application/json" }.merge!(credentials) }
  let(:admin_headers) { { HTTP_ACCEPT: "application/json" }.merge!(admin_credentials) }

  describe "PATCH /api/v1/posts/id" do

    it "updates status if user is admin" do
      patch "/api/v1/posts/"+"#{post.id}", params: {
        status: 'published'
      },
      headers: admin_headers
      post.reload
      expect(response.status).to eq 200
      expect(post.status).to eq 'published'
    end

    it "does not update status if user does not have admin privileges" do
      patch "/api/v1/posts/"+"#{post.id}", params: {
        status: 'published'
      }, 
      headers: headers
      post.reload
      expect(response.status).to eq 422
      expect(post.status).to eq 'pending'
    end
  end
end