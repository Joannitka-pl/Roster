# frozen_string_literal: true

class ShiftsController < ApplicationController
  before_action :set_shift, only: %i[edit update destroy]
  before_action :set_all_shifts, only: %i[ index update create destroy]

  def index; end

  def new
    @shift = Shift.new.decorate
  end

  def edit; end

  def create
    @shift = Shift.new(shift_params).decorate
    if @shift.save
      flash[:notice] = t('.notice')
      redirect_to action: "index"
    else
      render :new
    end
  end

  def update
    if @shift.update(shift_params)
      flash[:notice] = t('.notice')
      redirect_to action: "index"
    else
      render :new
    end
  end

  def destroy
    @shift.destroy
    flash[:notice] = t('.notice')
    redirect_to action: "index"
  end

  private

  def set_shift
    @shift = Shift.find(params[:id]).decorate
  end

  def set_all_shifts
    @shifts = Shift.all
  end

  def shift_params
    params.require(:shift).permit(:date, :hour, :user_id, :studio)
  end
end
