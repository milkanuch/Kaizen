class Room < ApplicationRecord
    validates_uniqueness_of :name

    has_many :messages
    has_many :participants, dependent: :destroy

    def self.create_private_room(users, room_name)
        single_room = Room.create(name: room_name, is_private: true)
        users.each do |user|
            Member.create(user_id: user.id, room_id: single_room.id)
        end
        single_room
    end
end
