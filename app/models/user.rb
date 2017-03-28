class User < ActiveRecord::Base
  self.table_name = 'user'
  self.primary_key = 'user_id'
  validates :user_name, :presence => true, :length => { :in => 6..20 }
  validates :user_password, :length => { :in => 6..20 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  has_many :roios, :foreign_key => 'user_id', :primary_key => 'user_id'
  has_many :reviews, :primary_key => 'username', :foreign_key => 'nick'
  has_many :moderators, :foreign_key => 'user_id', :primary_key => 'user_id'
  has_many :bands, :through => :moderators, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :user_trade_lists, :primary_key => 'user_id', :foreign_key => 'user_id'
  has_one :language, :primary_key => 'language_id', :foreign_key => 'language_id'
  has_many :user_theres, :primary_key => 'user_id', :foreign_key => 'user_id'

  before_save :encrypt_password
  after_save :clear_password


  def encrypt_password
    self.user_password = ApplicationController.helpers.encrypt_password(user_password)

  end

  def clear_password
    self.user_password = nil

  end


  def band_name
    band_name = ''
    if bands.present?
      bands.order('band_position').each do |f|
        band_name = band_name + f.band_details.to_s
      end
    end
    band_name.html_safe
  end

  def self.user_password2
    self.user_password2 = ''
  end

  def user_trade_list
    user_trade_list = Hash.new
    if  user_trade_lists.present?
      user_trade_lists.each do |f|
        user_trade_list[f.user_trade_list_id] = "#{f.time_entered}"
      end
    end
    user_trade_list
  end

  def user_id_md5
    Digest::MD5.hexdigest(user_id.to_s)
  end

  def language_name
    language.language_name
  end
end
