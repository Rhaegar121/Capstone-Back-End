require 'rails_helper'

RSpec.describe 'Favourites', type: :request do
  before do
    @user = User.create(fullname: 'User', email: 'user@gmail.com', password: 'password')
    @car = @user.cars.create(name: 'Car', price: 1000, description: 'Description', ratings: 1, image: 'Image')
    @favourite = @user.favourites.create(car_id: @car[:id], user_id: @user[:id])
  end

  describe 'GET /favourites' do
    before do
      get "/users/#{@user[:id]}/favourites"
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns all favourites' do
      expect(response.body).to eq({ cars: [@car], favourites: [@favourite] }.to_json)
    end
  end

  describe 'POST /favourites' do
    before do
      post "/users/#{@user[:id]}/favourites", params: { favourite: { car_id: @car[:id], user_id: @user[:id] } }
    end
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /favourites/:id' do
    before do
      delete "/users/#{@user[:id]}/favourites/#{@favourite[:id]}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(200)
    end
  end
end
