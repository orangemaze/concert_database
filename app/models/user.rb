class User < ActiveRecord::Base
  self.table_name = 'user'
  self.primary_key = 'user_id'
  has_many :roios, :foreign_key => 'user_id', :primary_key => 'user_id'
  has_many :reviews, :primary_key => 'username', :foreign_key => 'nick'
  has_many :moderators, :foreign_key => 'user_id', :primary_key => 'user_id'
  has_many :bands, :through => :moderators, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :user_trade_lists, :primary_key => 'user_id', :foreign_key => 'user_id'

  def band_name
    band_name = ''
    if bands.present?
      bands.order('band_position').each do |f|
        band_name = band_name + f.band_details.to_s
      end
    end
    band_name.html_safe
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


end