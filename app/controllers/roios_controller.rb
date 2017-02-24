class RoiosController < ApplicationController
  layout 'testui'
  def index
    puts 'Roios'.blue
    @data_result = Roio.all.limit(200) # commented for testing
  end

  def show
    @data_result = Roio.find(params[:id])
  end

  def new
    if cookies[:user_id].present?
      puts 'new'.blue
      @roio = Roio.new
    else

      note = t('you_must_be_logged_in_to_add_a_roio')
      begin
        redirect_to URI(request.referer).path + "?note=" + note
      rescue
        redirect_to :controller => 'index', :action => 'index' and return
      end
    end
  end

  def create
    @roio = Roio.new(roio_params)

    respond_to do |format|
      if @roio.save
        format.html { redirect_to @roio, :notice => 'ROIO was successfully created.' }
        format.json { render :show, :status => :created, :location => @roio }
      else
        format.html { render :new }
        format.json { render :json => @roio.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @roio = Roio.find(params[:id])
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
    params.require(:roio).permit(:concert_id, :bootleg_name, :roio_type, :release_label, :roio_format, :md5, :recorder, :cd, :user_id, :approved, :length, :lineage, :taper, :equipment, :generation, :source_warning, :band_id, :taper_location)
  end

end
