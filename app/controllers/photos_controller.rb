class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
    respond_to do | format |
      format.html
      format.json
    end
    
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  # POST /photos
  # POST /photos.json
  ROOM_ID = "room_id"
  REPRESENT = "represent"
  IMAGE = "image"
  IMAGE_CACHE = "image_cache"
  REMOVE_IMAGE = "remove_image"
  def make
    if photo = Photo.new(photo_params_mini)
      if photo.save
        render json: { image_url: photo.image.url, isroom: true }
        return
      end
    end
    render json: { image_url: nil, isroom: false }
  end


  private
  
    def photo_params_mini
      if params[ROOM_ID].nil?
        nil
      elsif params[REPRESENT].nil?
        nil
      elsif params[IMAGE].nil?
        nil
      else
        phot = {}
        phot[ROOM_ID] = params[ROOM_ID]
        phot[REPRESENT] = params[REPRESENT]
        phot[IMAGE] = params[IMAGE]
        phot
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:room_id, :img, :represent, :image, :image_cache, :remove_image)
    end
end
