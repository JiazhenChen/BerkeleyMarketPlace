require 'rails_helper'
require 'rack/test'


RSpec.describe UsersController, type: :controller do
  describe "can manage the profile page" do
  
    it 'can upload and submit profile picture' do
      post :profile, {:image => Rack::Test::UploadedFile.new('spec/controllers/images/doge.png', 'image/png')}
      expect(controller.params[:image]).not_to eq nil
      #controller.params[:image].should eql 'Some Body'
    end  
    
    # it 'can update profile picture' do
    #   post :profile, {:image => Rack::Test::UploadedFile.new('spec/controllers/images/doge.png', 'image/png')}
    #   expect(response).to redirect_to("/users/profile")
    # end 

  end
end
