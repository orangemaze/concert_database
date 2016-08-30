class Band < ActiveRecord::Base
  self.table_name = 'band'
  has_many :concert_bands, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_one :roio, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :band_members, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :tours, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :concerts, :through => :concert_bands, :primary_key => 'concert_id', :foreign_key => 'concert_id'
  has_many :members, :through => :band_members, :primary_key => 'band_id', :foreign_key => 'band_id'
  has_many :moderators, :foreign_key => 'band_id', :primary_key => 'band_id'
  has_many :users, :through => :moderators, :primary_key => 'user_id', :foreign_key => 'user_id'

  cattr_accessor :current_user


  def tour_name
    tour_name = Hash.new
    if  tours.present?
      tours.order('start_date').each do |f|
        tour_name[f.tours_id] = "<a href='/tour/#{f.tours_id}'>#{f.tour_name.to_s} <span class='text-muted'>
(#{ApplicationController.helpers.fix_bad_dates_in_db(f.start_date)} - #{ApplicationController.helpers.fix_bad_dates_in_db(f.end_date)})</span></a>"
      end
    end
    tour_name
  end

  def is_moderator
    puts ' == mod squad =='.blue
    puts band_id.to_s.red
    puts Band.inspect.to_s.blue
    data_result = Moderator.where("md5(user_id) = ? and band_id = ?", Band.current_user, band_id)
    puts data_result.inspect.blue
  end

  def band_years_active
    concert_dates = Hash.new
    if concerts.present?
      concerts.select('substr(concert_date, 1, 4) as band_concert_date, count(concert_date) as band_concert_count').group('substr(concert_date, 1, 4)').order('concert_date').each do |f|
        concert_dates[f.band_concert_date] = f.band_concert_count
      end
    end

    tag_id = [] # array
    tags = {}  # hash
    concert_dates.each do |years_info|
      tag_count = years_info[1]
      tag_name = years_info[0]
      tag_id << years_info[0]
      tags[tag_name] = tag_count
    end

    @max_size = 36
    @min_size = 9
    @max_qty = tags.max_by{|k,v| v}
    @min_qty = tags.min_by{|k,v| v}

    if @max_qty.present?
      @max_qtys = @max_qty[1]
    else
      @max_qtys = 0
    end

    if @min_qty.present?
      @min_qtys = @min_qty[1]
    else
      @min_qtys = 0
    end

    @spread = @max_qty[1] - @min_qty[1]
    if @spread == 0
      @spread = 1
    end

    @step = (@max_size.to_f - @min_size.to_f) / (@spread.to_f)
    if tags.empty?
      @here = 'here1'
    else
      tag_counting = 0
      tags.each do |k,v|
        @size = (@min_size.to_f + ((v.to_f - @min_qty[1].to_f) * @step.to_f))

        if tag_counting >= 1
          @tag_return = "#{@tag_return.to_s} <strong>&middot;</strong> "
        end

        if v.to_f > 1
          @items = 'listings'
        else
          @items = 'listing'
        end

        @tag_return = "#{@tag_return.to_s} <a href=\"/lists/years/#{k}?band_id=#{@band_id}\" style=\"font-size: #{@size.to_s}px\" title=\"#{k} has #{v} #{@items}\">#{k}</a> "

        tag_counting +=1
      end
    end
    @tag_return
  end

  def band_members_over_the_years

    tag_id = [] # array
    tags = {}  # hash
    # puts "here1".blue
    # members tag cloud
    if members.present?
      members.select("count(band_members.concert_id) as member_count, CONCAT(members.member_fname,' ',members.member_lname) as full_name,  members.member_id as member_id").where('band_members.member_id = members.member_id').group('member_id').order('members.member_lname').each do |f|
        # puts f.member_count.to_s.red
        # puts f.full_name.to_s.red
        # puts f.member_id.to_s.red

        tag_count = f.member_count
        tag_name = f.full_name.to_s
        tag_id << f.member_id
        tags[tag_name] = tag_count
      end
    end



    # puts 'here2'.blue
    @max_size = 36
    @min_size = 9
    @max_qty = tags.max_by{|k,v| v}
    @min_qty = tags.min_by{|k,v| v}

    if @max_qty.present?
      @max_qtys = @max_qty[1]
    else
      @max_qtys = 0
    end

    if @min_qty.present?
      @min_qtys = @min_qty[1]
    else
      @min_qtys = 0
    end

    @spread = @max_qtys - @min_qtys
    if @spread == 0
      @spread = 1
    end

    # puts "are we here".red

    @step = (@max_size.to_f - @min_size.to_f) / (@spread.to_f)
    if tags.empty?
      @here = 'here1'
      # puts "empty".red
    else
      puts 'full'.red
      tag_counting = 0
      tags.each do |k,v|
        @size = (@min_size.to_f + ((v.to_f - @min_qty[1].to_f) * @step.to_f))

        #if ((v != '392') or (v != '44'))
          if tag_counting >= 1
            @tag_return_members = @tag_return_members.to_s + ' <strong>&middot;</strong> '
          end

          # puts 'here'.red
          if v.to_f > 1
            @items = 'listings'
          else
            @items = 'listing'
          end

          @key_val = URI::escape(k)


          @tag_return_members = "#{@tag_return_members.to_s}<a href=\"/members/#{tag_id[tag_counting]}\" style=\"font-size: #{@size.to_s}px\" title=\"#{k} has #{v} #{@items}\">#{k}</a> "

          tag_counting +=1
        # end
      end

    end
    @tag_return_members

  end
end