Rails.application.routes.draw do
  # deviseのモデルを作成したときに同時に記述される# devise_forはユーザー機能に必要なルーティングを一気に生成してくれるdeviseのメソッドです。
  devise_for :users
  root to: 'tweets#index'
  namespace :tweets do
    resources :searches, only: :index
  end
  resources :tweets do
    resources :comments, only: :create
  # resources :tweets, only: [:index, :new, :create, :destroy, :edit, :update, :show]
  # アクションが全部あるから下の表記が短くて済む 上のはonlyは指定してあるアクションが発動する exceptはそれ以外が発動する
  
  end
  resources :users, only: :show
  
end
