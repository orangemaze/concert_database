class BandMember < ActiveRecord::Base
  self.table_name = 'band_members'
  has_many :concert_bands, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :bands, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :members, :primary_key => 'member_id', :foreign_key => 'member_id'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'

  include ActionDispatch::Routing::UrlFor
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  def bands_members
    bands_members = ''
    if  members.present?
      members.order('member_lname').each do |f|
        # need to come up with a filter to just show members from the right band, currently showing all members for each band
        bands_members = "#{bands_members.to_s} #{link_to "#{member_fname.to_s} #{member_lname.to_s}", member_path(f.member_id.to_s) + "?locale=#{I18n.locale.to_s}"}"
      end
    end
    bands_members.html_safe
  end

   def concert_id
     concerts.present? ? concerts.concert_id.to_s : concerts.inspect
   end

  def member_lname
    member_lname = ''
    if members.present?
      members.each do |f|
        member_lname = member_lname.to_s + f.member_lname.to_s
      end
    end
    member_lname.html_safe
  end

  def member_fname
    member_fname = ''
    if members.present?
      members.each do |f|
        member_fname = member_fname.to_s + f.member_fname.to_s
      end
    end
    member_fname.html_safe
  end


end