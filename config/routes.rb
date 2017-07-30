Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #post '/jobs_structures/set_sequence' => 'jobs_structures#set_sequence'
  root to: "jobs_structures#index"
  get '/input', to: 'jobs_structures#input', as: 'input'
  post '/output', to: 'jobs_structures#output', as: 'output'

end
