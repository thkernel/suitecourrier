# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  uid              :string
#  content          :text
#  status           :string
#  user_id          :bigint
#  commentable_type :string
#  commentable_id   :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
