# frozen_string_literal: true

class MysteryLunchEmployee < ApplicationRecord
  belongs_to :employee
  belongs_to :mystery_lunch

  scope :current_yearmonth_by_employee, lambda { |employee_id|
                                          joins(:mystery_lunch)
                                            .where("mystery_lunches.year_month = #{MysteryLunch::CURRENT_YEARMONTH}")
                                            .where("mystery_lunch_employees.employee_id = #{employee_id}")
                                        }
  
  scope :pair_current_yearmonth, lambda { |yearmonth|
    joins(:mystery_lunch)
      .where("mystery_lunches.year_month = #{yearmonth}")
      .group('mystery_lunch_id')
      .having('COUNT(employee_id) = 2')
      .select('mystery_lunch_id')
  }                                       
end
