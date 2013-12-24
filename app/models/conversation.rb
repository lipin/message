# == Schema Information
#
# Table name: conversations
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  target_user_id :integer
#  body           :text
#  is_read        :boolean          default(FALSE)
#  is_archived    :boolean          default(FALSE)
#  created_at     :datetime
#  updated_at     :datetime
#  messages_count :integer          default(0)
#

class Conversation < ActiveRecord::Base

  belongs_to :user, counter_cache: true

  belongs_to :target_user

  has_many :messages

  scope :unread, -> { where(is_read: false) }
  scope :read, ->{ where(is_read: true) }

  scope :unarchived, -> { where(is_archived: false) }
  scope :archived, -> { where(is_archived: true) }

  def mark_as_read!
    update_attribute(:is_read, true)
  end

end
