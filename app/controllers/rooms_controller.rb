class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end
  
  def create
    @room = Room.new(room_params)

    if params[:room][:image]
      @room.image.attach(params[:room][:image])
    end

    if @room.save
      redirect_to @room
    else
      render :new
    end
  end

  def edit
    @room = Room.find(params[:id])
  end
  
  def update
    @room = Room.find(params[:id])

    if params[:room][:image]
      @room.image.attach(params[:room][:image])
    end

    if @room.update(room_params)
      redirect_to @room
    else
      render :edit
    end
  end
  
  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end

  def search
    if params[:query].present?
      @rooms = Room.where("name LIKE ?", "%#{params[:query]}%")
    else
      @rooms = Room.all
    end
  end  

  private

  def room_params
    params.require(:room).permit(:image, :name, :description, :price, :address)
  end
end  
