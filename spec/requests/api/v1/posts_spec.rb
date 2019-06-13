RSpec.describe Api::V1::PostsController, type: :request do
let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe "GET /api/v1/posts" do

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

      posts= Post.all

      posts.each do |post|
        expect(json_response[posts.index(post)]).to include('id')
        expect(json_response[posts.index(post)]).to include('status')
        expect(json_response[posts.index(post)]).to include('latitude')
        expect(json_response[posts.index(post)]).to include('longitude')
      end
    end
  end

  describe "POST /api/v1/posts" do

    describe "successfully" do
      before do
        post "/api/v1/posts", params: {
          post: {
            image: ('spec/fixtures/dummy_image.jpg'),
            caption: 'Lorem ipsum dolor',
            category: 'work',
            longitude: 53.06,
            latitude: 18.03,
            }
        }, headers: headers
      end

      it "creates a new post" do
        expect(json_response["message"]).to eq "Successfully created"
        expect(response.status).to eq 200
        
      end

      it "sends back into the response the newly created post information" do
        post = Post.last
        expect(json_response["id"]).to eq post.id
      end 
    end

    describe "POST /api/v1/posts" do

      describe "unsuccessfully" do
        it "can not be created without all fields filled in" do
          post "/api/v1/posts", params: {
          post: {
            image: ('spec/fixtures/dummy_image.jpg'),
            category: 'work',
            longitude: 53.06,
            latitude: 18.03,
            }
        }, headers: headers
  
          expect(json_response['error']).to eq ["Caption can't be blank"]
          expect(response.status).to eq 422
        end

        it "can not be created if caption is more than 140 characters" do

          post "/api/v1/posts", params: {
            post: {
              image: ('spec/fixtures/dummy_image.jpg'),
              caption: "Zanes hair is the most beautiful hair I have ever seen!!!!!Zanes hair is the most beautiful hair I have ever seen!!!!!Zanes hair is the most beautiful hair I have ever seen!!!!!Zanes hair is the most beautiful hair I have ever seen!!!!!Zanes hair is the most beautiful hair I have ever seen!!!!!",
              category: 'work',
              longitude: 53.06,
              latitude: 18.03,
              }
          }, headers: headers

          expect(json_response['error']).to eq ["Caption is too long (maximum is 140 characters)"]
        end
      end
    end
  end
end




  
