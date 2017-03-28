class RegistersController < ApplicationController
  layout 'testui'

  def new
    @register = User.new
  end

  def edit
    puts params[:id].inspect.red
    @register = User.where('md5(user_id) = ?', params[:id]).first
  end


  def create
    @register = User.new(user_params)
    @register['activation_code'] = Digest::MD5.hexdigest(Time.now.to_s)
    @register['user_password'] = params[:user][:user_password]


    respond_to do |format|
      begin
        if @register.save
          puts '-=>  <=-'  
          puts @register.inspect.magenta 
          puts @register.user_id.inspect.magenta 
          format.html { redirect_to register_path(Digest::MD5.hexdigest(@register.user_id.to_s)), :notice => 'User was successfully created.' }
          format.json { render :show, :status => :created, :location => @register }
        else
          format.html { render :action => "new", :params => @register.errors }
          format.json { render :json => @register.errors, :status => :unprocessable_entity }
        end
      rescue
          #format.html { redirect_to new_register_path(@user.errors) }
          @register.errors.add(:base, 'This is a duplicate entry, please choose another name.')
          puts @register.errors.messages.inspect.magenta
          format.html { render :action => "new", :params => @register.errors}
      end
    end
  end

  def show
    @data_result = User.where('md5(user_id) = ?', params[:id]).first
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @register = User.where('md5(user_id) = ?', params[:id]).limit(1)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:user_name, :user_password, :user_password2, :f_name, :l_name, :email, :url, :quote, :other, :language_id, :activation_code, :city, :state, :country)
  end


end
