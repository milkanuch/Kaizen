class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :friends 
    has_many :messages
    
    has_one_attached :avatar 
    
    validates :firstname, presence: true
    validates :surname, presence: true
    validates :nickname, presence: true, uniqueness: true
end
