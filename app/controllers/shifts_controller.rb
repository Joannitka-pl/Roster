# frozen_string_literal: true

class ShiftsController < ApplicationController
  before_action :set_shift, only: %i[show edit update destroy]
  def show; end

  def index
    @shifts = Shift.all
  end

  def new
    @shift = Shift.new
  end

  def edit; end

  def create
    @shift = Shift.new(params.require(:shift).permit(:date, :hour, :user_id, :studio))
    if @shift.save
      redirect_to @shift
    else
      render :new
    end
  end

  def update
    @shift.update(params.require(:shift).permit(:date, :hour, :user_id, :studio))
    if @shift.save
      redirect_to @shift
    else
      render :new
    end
  end

  def destroy
    @shift.destroy
  end

  private

  def set_shift
    @shift = Shift.find(params[:id])
  end
end
