class Message < ApplicationRecord
    belongs_to :user
    belongs_to :room

    before_create :message_create

    def message_create
        is_member = Member.where(user_id: user_id, room_id: room_id).first
        throw :abort unless
    end
end
