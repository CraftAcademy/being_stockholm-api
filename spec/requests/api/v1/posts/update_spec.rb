RSpec.describe Api::V1::PostsController, type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:user, admin: true, email: 'noel@craft.com') }
  let(:post) { FactoryBot.create(:post) }
  let(:credentials) { user.create_new_auth_token }
  let(:admin_credentials) { admin.create_new_auth_token }
  let(:headers) { { HTTP_ACCEPT: "application/json" }.merge!(credentials) }
  let(:admin_headers) { { HTTP_ACCEPT: "application/json" }.merge!(admin_credentials) }

  describe "PATCH /api/v1/posts/id" do

    it "updates status if user is admin" do
      patch "/api/v1/posts/"+"#{post.id}", headers: admin_headers
      expect(response.status).to eq 200
    end

    it "does not update status if user does not have admin privileges" do
      patch "/api/v1/posts/"+"#{post.id}", headers: headers
      expect(response.status).to eq 422
    end
  end
end