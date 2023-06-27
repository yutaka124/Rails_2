class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show]

  def index
    @reservations = current_user.reservations
  end

  def new
    @room = Room.find(params[:room_id])
    @reservation = current_user.reservations.build(room: @room)
  end

  def create
    @room = Room.find(params[:reservation][:room_id])
    @reservation = current_user.reservations.new(reservation_params)
    if @reservation.save
      redirect_to reservations_path
    else
      Rails.logger.info @reservation.errors.full_messages.join(", ")
      render :new
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_url, notice: 'Reservation was successfully destroyed.'
  end

  def confirm
    @reservation = current_user.reservations.new(reservation_params)
    if @reservation.valid?
      # If the reservation is valid, render the confirm page.
      render :confirm
    else
      # If the reservation is invalid, redirect to the new reservation form.
      flash[:error] = @reservation.errors.full_messages
      redirect_to new_reservation_path(room_id: @reservation.room.id)
    end
  end
  
  private
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :guests, :user_id, :room_id)
  end   
end
