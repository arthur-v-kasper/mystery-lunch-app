# frozen_string_literal: true

class MysteryLunchesController < ApplicationController
  def index    
    @mystery_lunches = MysteryLunch.where(year_month:)    
  end

  private

  def year_month
    year_month = params[:year_month]
    year_month || MysteryLunch::CURRENT_YEARMONTH
  end
end
