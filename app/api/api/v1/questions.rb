module API
  module V1
    class Questions < Grape::API
      resource :questions do
        desc 'Retrieve questions'
        get do
          questions = Question.all.inject([]) do |collection, question|
            collection << question
            { questions: collection }.to_json
          end
        end
      end
    end  
  end
end  
