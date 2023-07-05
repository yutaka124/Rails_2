class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @rooms = current_user.rooms
  end
  
  def create
    @room = current_user.rooms.build(room_params)

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
    if @room.destroy
      flash[:notice] = "施設は削除されました"
      redirect_to own_rooms_path
    else
      flash[:alert] = "施設を削除できませんでした"
      render :edit
    end
  end

  def search
    @rooms = Room.where('name LIKE ? OR description LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
  end

  def search_by_area
    if params[:area].present?
      @rooms = Room.where("address LIKE ?", "%#{params[:area]}%")
    else
      @rooms = Room.all
    end
  end

  def own
    @rooms = Room.where(user_id: current_user.id)
  end

  private

  def room_params
    params.require(:room).permit(:image, :name, :description, :price, :address)
  end
end  
