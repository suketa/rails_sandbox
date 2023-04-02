class HabitsController < ApplicationController
  before_action :set_habit

  def show
  end

  def plus
    @habit.increment!(:count)
    render :result
  end

  def minus
    @habit.decrement!(:count)
    render :result
  end

  private

  def set_habit
    @habit = Habit.find_by(id: params[:id])
  end
end
