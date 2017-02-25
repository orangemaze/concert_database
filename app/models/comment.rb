class Comment < ActiveRecord::Base
  self.table_name = 'reviews'
  has_many :roios, :primary_key => 'bootleg_id', :foreign_key => 'bootleg_id'
  has_many :concerts, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :users, :primary_key => 'nick', :foreign_key => 'username'


  def bootleg_name
    bootleg_name = ''
    if roios.present?
      roios.each do |f|
        bootleg_name = bootleg_name + f.bootleg_name.gsub(/\\'/, '\'').to_s
      end
    end
    bootleg_name.html_safe
  end

end
