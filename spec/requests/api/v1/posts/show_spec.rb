RSpec.describe Api::V1::PostsController, type: :request do
let(:user) { FactoryBot.create(:user) }
let(:credentials) { user.create_new_auth_token }
let(:headers) { { HTTP_ACCEPT: "application/json" }.merge!(credentials) }
let(:not_headers) { {HTTP_ACCEPT: "application/json"} }
  
  describe "GET /api/v1/posts/id" do
    before do
      post "/api/v1/posts", params: {
        image: {
          type: "image/png",
          encoder: "name=carbon (5).png;base64",
          data: "iVBORw0KGgoAAAANSUhEUgAABjAAAAOmCAYAAABFYNwHAAAgAElEQVR4XuzdB3gU1cLG8Te9EEgISQi9I71KFbBXbFixN6zfvSiIjSuKInoVFOyIDcWuiKiIol4Q6SBVOtI7IYSWBkm+58y6yW4a2SS7O4n/eZ7vuWR35pwzvzO76zf",
          extension: "png" 
        },
        caption: 'Lorem ipsum dolor',
        category: 'work',
        longitude: 53.06,
        latitude: 18.03,
      }, 
      headers: headers
      get "/api/v1/posts/"+"#{Post.last.id}", headers: headers
    end
    
    it "returns a success response" do
      expect(response.status).to eq 200
    end

    it "returns a specific post" do
      post = Post.last
      expect(json_response['id']).to eq post.id
    end

    it "returns image object in the response" do      
      expect(json_response).to include 'image'
    end
  end  
end