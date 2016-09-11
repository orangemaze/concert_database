class RoiosController < ApplicationController
  layout 'testui'
  def index
    puts 'Roios'.blue
    @data_result = Roio.all.limit(200) # commented for testing
  end

  def show
    @data_result = Roio.find(params[:id])
  end

  def edit
    @roio = Roio.find(params[:id])
    puts 'edit'.blue
    puts @roio.inspect.red
    if @moderator_band_names.present?
      if @moderator_band_names.has_value?(@roio.band_name[0]).present? or (session[:admin].to_i == 1)
        @is_moderator = 'y'
      else
        redirect_to(index_index_path)
      end
    else
      redirect_to(index_index_path)
    end
  end

  def update
    @roio = Roio.find(params[:id])
    respond_to do |format|
      if @roio.update(roio_params)
        format.html { redirect_to @roio }
        format.json { render :show, :status => :ok, :location => @roio }
      else
        format.html { render :edit }
        format.json { render :json => @roio.errors, :status => :unprocessable_entity }
      end
    end
  end

  private
  def set_index
    @data_result = Roio.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def roio_params
    params.require(:roio).permit(:bootleg_name, :roio_type, :release_label, :roio_format, :md5, :recorder, :cd, :user_id, :approved, :length, :lineage, :taper, :equipment, :generation, :source_warning, :band_id, :taper_location)
  end

end