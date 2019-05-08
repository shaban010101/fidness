module API
  module V1
    class Users < Grape::API
      resource :users do
        desc 'Create a new user'
        params do
          requires :email, type: String
          requires :username, type: String
          requires :first_name, type: String
          requires :last_name, type: String
          requires :password, type: String
        end

        post do
          if User.create!(declared(params))
            status 201
          else
            status 422
          end  
        end

        route_param :id do
          resources :answers do
            params do
              requires :question_id, type: Integer
            end
            post do
              Answer.create!(
                user_id: params[:id],
                question_id: params[:question_id])
            end

            get do
              answers = Answer.where(user_id: params[:id])
              { answers: answers }
            end
          end
        end  
      end
    end
  end
end
