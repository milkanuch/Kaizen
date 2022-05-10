class Room < ApplicationRecord
    has_many :messages
    has_many :members, dependent: :destroy

    def self.create_room(room_users)
        room_storage = Room.create(first_user_id: room_users[0], second_user_id: room_users[1])
        room_users.each do |user|
            Member.create(user_id: user, room_id: room_storage.id)
        end
        room_storage
    end
end
