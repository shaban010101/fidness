module API
  module V1 
    class Base < Grape::API
      prefix "api"
      version "v1", using: :path
      default_format :json
      format :json

      mount API::V1::Users
      mount API::V1::Questions
    end
  end  
end
