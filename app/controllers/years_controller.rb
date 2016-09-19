class YearsController < ApplicationController
  layout 'testui'

  puts '=== years controller ==='.red

  def index
    # @data_result = Band.all # .limit(20) # commented for testing
  end

  def show
    start_date = params[:id].to_s + '-01-01'
    end_date = params[:id].to_s + '-12-31'
    band_id = params[:band_id]

    band_data = Band.find(params[:band_id])

    @data_result = Concert.select('concerts.concert_date, band.band_name, concerts.concert_id').joins('left join concert_band on concert_band.concert_id = concerts.concert_id').joins('left join band on band.band_id = concert_band.band_id').where('concerts.concert_date > ? and concerts.concert_date < ? and concert_band.band_id = ?', start_date, end_date, band_id)


    puts @moderator_band_names.inspect.blue
    puts band_data.band_name.green
    if @moderator_band_names.present?
      puts 'and here...'.red
      if @moderator_band_names.has_value?(band_data.band_name).present? or (session[:admin].to_i == 1)
        puts 'finally!!'.blue
        @is_moderator = 'y'
      else
        @is_moderator = 'n'
      end
    else
      @is_moderator = 'n'
    end
  end
end