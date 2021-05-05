# frozen_string_literal: true

class ShiftsController < ApplicationController
  before_action :set_shift, only: %i[edit update destroy]

  def index
    @shifts = Shift.all
  end

  def new
    @shift = Shift.new.decorate
  end

  def edit; end

  def create
    @shift = Shift.new(shift_params).decorate
  
    if @shift.save
      flash[:notice] = t('.notice')
      redirect_to shifts_path
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  def update
    if @shift.update(shift_params)
      flash[:notice] = t('.notice')
      redirect_to shifts_path
    else
      flash.now[:alert] = t('.error')
      render :edit
    end
  end

  def destroy
    @shift.destroy
    flash[:notice] = t('.notice')
    redirect_to shifts_path
  end

  private

  def set_shift
    @shift = Shift.find(params[:id]).decorate
  end

  def shift_params
    params.require(:shift).permit(:starting_at, :duration, :studio)
  end
end
