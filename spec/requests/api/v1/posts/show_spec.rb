RSpec.describe Api::V1::PostsController, type: :request do

  let(:headers) { { HTTP_ACCEPT: 'application/json' } }
  let(:image) {
    {type: "image/png",
    encoder: "name=carbon (5).png;base64",
    data: "iVBORw0KGgoAAAANSUhEUgAABjAAAAOmCAYAAABFYNwHAAAgAElEQVR4XuzdB3gU1cLG8Te9EEgISQi9I71KFbBXbFixN6zfvSiIjSuKInoVFOyIDcWuiKiIol4Q6SBVOtI7IYSWBkm+58y6yW4a2SS7O4n/eZ7vuWR35pwzvzO76zf",
    extension: "png" }
  }  
  
  describe "GET /api/v1/posts/id" do
    before do
      post = FactoryBot.create(:post)
      DecodeImageService.attach_image(image, post.image)
      get "/api/v1/posts/"+"#{post.id}", headers: headers
    end
    
    it "returns a success response" do
      expect(response.status).to eq 200
    end

    it "returns a specific post" do
      post = Post.last
      expect(json_response['post']['id']).to eq post.id
    end

    it "returns the attached image in the response" do
      post = Post.last
      attached_image = "iVBORw0KGgoAAAANSUhEUgAABjAAAAOmCAYAAABFYNwHAAAgAElEQVR4Xuzd\nB3gU1cLG8Te9EEgISQi9I71KFbBXbFixN6zfvSiIjSuKInoVFOyIDcWuiKiI\nol4Q6SBVOtI7IYSWBkm+58y6yW4a2SS7O4n/eZ7vuWR35pwzvzO76zcK\n"
      expect(json_response['image']).to eq attached_image
    end

  end  
end
