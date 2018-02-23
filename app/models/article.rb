class Article < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  
  default_scope {order(created_at: :desc)} #you'd better not to use default_scope because it would cause another order-related problem in the future
end
