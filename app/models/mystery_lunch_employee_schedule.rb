class MysteryLunchEmployeeSchedule < ApplicationRecord
  belongs_to :employee

  attribute :selected, default: 0

  scope :not_selected, -> { where('selected = 0') }

  def selected!
    self.selected = 1
    save!
  end
end
