class HabitsController < ApplicationController
  def show
    @habit = Habit.first
  end
end
