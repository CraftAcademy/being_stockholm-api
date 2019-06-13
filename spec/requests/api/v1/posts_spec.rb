RSpec.describe Api::V1::PostsController, type: :request do
let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe "GET /api/v1/posts" do
    posts= Post.all

    before do
      5.times { FactoryBot.create(:post) }
    end

    it "returns a collection of posts" do
      get "/api/v1/posts", headers: headers
      expect(json_response.count).to eq 5
    end

    it "returns 200 response" do
      get "/api/v1/posts", headers: headers
      expect(response.status).to eq 200
    end
    
    it "has correct keys in the response" do
      get "/api/v1/posts", headers: headers

      posts.each do |post|
        expect(json_response[posts.index(post)]).to include('id')
        expect(json_response[posts.index(post)]).to include('status')
        expect(json_response[posts.index(post)]).to include('latitude')
        expect(json_response[posts.index(post)]).to include('longitude')
      end
    end

    it "has correct status on response" do
      get "/api/v1/posts", headers: headers
     
      posts.each do |post|
        expect(post.published?).to be(false)
        expect(post.pending?).to be(true)
        expect(post.declined?).to be(false)
      end
    end

    it "has correct category on response" do
      get "/api/v1/posts", headers: headers
     
      posts.each do |post|
        expect(post.work?).to be(false)
        expect(post.play?).to be(true)
      end
    end
  end
end