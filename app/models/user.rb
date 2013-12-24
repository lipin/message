# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  gender                 :string(255)
#  conversations_count    :integer          default(0)
#

class User < ActiveRecord::Base

  attr_readonly :conversations_count

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  symbolize :gender, in: [ :male, :female ], scopes: :shallow, methods: true, default: :male


  ## 用户发件箱
  has_many :conversations

  ## 用户收件箱
  has_many :inbox_conversations, class_name: 'Conversation', foreign_key: 'target_user_id'

  def unread_inbox_conversations
    inbox_conversations.unread
  end
end
