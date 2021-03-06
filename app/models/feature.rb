# == Schema Information
#
# Table name: features
#
#  id            :bigint           not null, primary key
#  uid           :string
#  name          :string
#  subject_class :string
#  description   :text
#  status        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Feature < ApplicationRecord
  include SharedUtils::Generate

  before_save :generate_random_number_uid


  has_many :permissions, dependent: :destroy
  # Validations.
  validates :name, presence: true, uniqueness: true

  # Change default params ID to uid
  def to_param
    uid
  end

  
end
