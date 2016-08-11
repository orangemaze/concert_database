class BandMember < ActiveRecord::Base
  self.table_name = 'band_members'
  has_many :concert_bands, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :bands, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :members, :primary_key => 'member_id', :foreign_key => 'member_id'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'

  def bands_members
    bands_members = ''
    if  members.present?
      members.each do |f|
        # need to come up with a filter to just show members from the right band, currently showing all members for each band
        bands_members = bands_members.to_s + f.member_fname.to_s + ' ' + f.member_lname.to_s + '<br>'
      end
    end
    bands_members.html_safe
  end

   def concert_id
     concerts.present? ? concerts.concert_id.to_s : concerts.inspect
   end
end