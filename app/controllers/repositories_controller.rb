class RepositoriesController < ApplicationController
  
  def index
    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      # why do we only need accept and authorization?
      req.headers = {'Accept': 'application/json', 'Authorization': "token #{session[:token]}"}
    end
    # binding.pry
      @body = JSON.parse(resp.body)
  end

end
