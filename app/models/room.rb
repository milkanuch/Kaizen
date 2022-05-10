class Room < ApplicationRecord
    has_many :messages
    has_many :members, dependent: :destroy

    def self.create_private_room(users)
        room_storage = Room.create(first_user_id: users[0].id, second_user_id: users[1].id)
        users.each do |user|
            Member.create(user_id: user.id, room_id: room_storage.id)
        end
        room_storage
    end
end
