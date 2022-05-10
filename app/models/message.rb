class Message < ApplicationRecord
    belongs_to :user
    belongs_to :room

    before_create :message_create

    validates :message_body, presence: true
    def message_create
        is_member = Member.where(user_id: user_id, room_id: room_id).first
        throw :abort unless is_member
    end
end
