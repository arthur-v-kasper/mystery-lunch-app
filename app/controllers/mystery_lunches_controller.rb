# frozen_string_literal: true

class MysteryLunchesController < ApplicationController
  def index
    @mystery_lunches = MysteryLunch.where(year_month: 202301)    
  end
end
