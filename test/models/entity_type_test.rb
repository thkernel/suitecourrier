# == Schema Information
#
# Table name: entity_types
#
#  id          :bigint           not null, primary key
#  uid         :string
#  name        :string
#  description :text
#  status      :string
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class EntityTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
