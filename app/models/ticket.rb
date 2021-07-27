# == Schema Information
#
# Table name: tickets
#
#  id               :bigint           not null, primary key
#  uid              :string
#  reference        :string
#  ticket_type_id   :bigint
#  title            :string
#  priority_id      :bigint
#  content          :text
#  due_date         :datetime
#  start_date       :datetime
#  completed_date   :datetime
#  ticket_status_id :bigint
#  year             :integer
#  user_id          :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Ticket < ApplicationRecord
  include SharedUtils::Generate

  before_save :generate_random_number_uid

  
  belongs_to :user
  belongs_to :ticket_type
  belongs_to :ticket_status
  belongs_to :ticket_priority

  has_many_attached :files
  has_many :ticket_users, dependent: :destroy
  
  accepts_nested_attributes_for :ticket_users

end
