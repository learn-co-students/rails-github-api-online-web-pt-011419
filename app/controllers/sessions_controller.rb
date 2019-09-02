class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.body = {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"], 
      code: params[:code] }
      req.headers['Accept'] = 'application/json'
    end
      # binding.pry
      body = JSON.parse(resp.body)
      session[:token] = body["access_token"]
      # redirect_to root_path
      
      
      user_response = Faraday.get("https://api.github.com/user") do |req|
        req.headers = { 'Accept': 'application/json', 'Authorization': "token #{session[:token]}" }
         end
         user = JSON.parse(user_response.body)
         session[:username] = user["login"]
        redirect_to root_path
      end
end
