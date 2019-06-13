RSpec.describe Api::V1::PostsController, type: :request do
  let(:headers) { { HTTP_ACCEPT: 'application/json' } }

  describe "POST /api/v1/posts" do

    describe "successfully" do
      before do
        post "/api/v1/posts", params: {
          post: {
            image: {
              io: File.open('spec/fixtures/dummy_image.jpg'), filename: 'attachment.jpg', content_type: 'image/jpg'
              },
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


      it "attaches the uploaded image" do
        post = Post.last
        # post.image.attach(io: File.open('spec/fixtures/dummy_image.jpg'), filename: 'attachment.jpg', content_type: 'image/jpg')
        expect(post.image).to be_attached
      end
    end

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