class MysteryLunchEmployeeSchedule < ApplicationRecord
  belongs_to :employee

  attribute :selected, default: 0

  scope :not_selected, -> { where('selected = 0') }
  scope 

  def selected!
    self.selected = 1
    self.save!
  end
end
