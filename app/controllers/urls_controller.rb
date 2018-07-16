class UrlsController < ApplicationController
  # before_action :authenticate_user!, except:[:new, :create]

  # GET /urls
  # GET /urls.json
  def index
    
  end

  # GET /urls/1
  # GET /urls/1.json
  def show

  end

  # GET /urls/new (root)
  def new
    @url = Url.new
  end

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(url_params)#.merge(user: current_user))
    
    respond_to do |format|
      if @url.save
        format.js {}
      else
        format.js { render :create_invalid, status: :unprocessable_entity }
      end
    end
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  # GET /:shortened
  def redirect
    origin = Url.shortened_to_origin(params[:shortened])
    if origin.nil?
      raise ActiveRecord::RecordNotFound # 404
      # render 'errors/not_found', status: :not_found
    else
      redirect_to origin, status: :moved_permanently # 301
    end
  end

  # GET /:shortened/p
  def preview
    
  end

  # GET /:shortened/s
  def statistic
    
  end

  private

    def set_url

    end

    def url_params
      params.require(:url).permit(:origin, :shortened)
    end
end
