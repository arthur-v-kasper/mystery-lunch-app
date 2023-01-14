# frozen_string_literal: true

ActiveRecord::Base.transaction do
  puts 'Creating departments...'
  department = %w[Operations Sales Marketing Risk Management Finance HR Development Data]
  department.each { |department| Department.create!(name: department) }

  puts 'Creating fake admin user...'
  User.create!(user_name: 'admin@creditshelf.com', password: 'fakepassword')

  puts 'Creating fake employees...'
  75.times do
    randomly_department = Department.find_by(name: department.sample)
    full_name = Faker::Name.name
    email = Faker::Internet.email(name: full_name,
                                  separators: '_', domain: 'creditshelf.com')
    Employee.create!(full_name:,
                     email:,
                     department: randomly_department)
  end

  puts 'Creating fake current mystery lunches...'
  def quantity_employees_not_selected
    MysteryLunchEmployeeSchedule.not_selected.count
  end

  def create_mystery_lunch
    # (Time.now.months_ago(3)).strftime("%Y%m").to_i
    MysteryLunch.create!
  end

  def create_mystery_lunch_employees(mystery_lunch_id, employee_id)
    MysteryLunchEmployeeSchedule.find_by(employee_id:).selected!
    MysteryLunchEmployee.create!(mystery_lunch_id:, employee_id:)
  end

  def check_last_three_lunches(random_employees)    
    MysteryLunchEmployee.joins(:mystery_lunch)
    .where("mystery_lunches.year_month >= ? AND mystery_lunch_employees.employee_id IN (?)", 
           MysteryLunch::THREE_YEARMONTHS_AGO, random_employees.pluck(:employee_id))
    .group("mystery_lunches.year_month")
    .having("count(DISTINCT mystery_lunch_id) = 1")
    .pluck("mystery_lunches.year_month")

  end

  def pair_employee_mystery_lunch
    random_employees = MysteryLunchEmployeeSchedule.not_selected.sample(2)
    mystery_lunch = create_mystery_lunch
    check_last_three_lunches(random_employees)
    random_employees.each do |random_employee|
      create_mystery_lunch_employees(mystery_lunch.id,
                                     random_employee.employee_id)
    end
  end

  def set_last_employee_mystery_lunch
    last_employee = MysteryLunchEmployeeSchedule.not_selected.first
    department_id = last_employee.employee.department.id
    mystery_lunch = mystery_lunch_diferent_departament(department_id)
    create_mystery_lunch_employees(mystery_lunch.mystery_lunch_id,
                                   last_employee.employee.id)
  end

  def mystery_lunch_diferent_departament(department_id)
    MysteryLunchEmployee.joins(employee: :department).joins(:mystery_lunch)
                        .where("mystery_lunches.year_month = #{MysteryLunch::CURRENT_YEARMONTH}")
                        .where("departments.id != #{department_id}")
                        .group('mystery_lunch_employees.mystery_lunch_id')
                        .having('COUNT(DISTINCT departments.id) > 1')
                        .select('mystery_lunch_employees.mystery_lunch_id')
                        .first
  end

  loop do
    create_mystery_lunch
    pair_employee_mystery_lunch

    set_last_employee_mystery_lunch if quantity_employees_not_selected == 1

    break if quantity_employees_not_selected == 0
  end
end

# select ml.year_month  from mystery_lunch_employees mle
#  join mystery_lunches ml ON ml.id = mle.mystery_lunch_id and ml.year_month >= 202210 
# WHERE mle.employee_id in (64, 54)
# GROUP by ml.year_month
# HAVING count(DISTINCT mle.mystery_lunch_id) = 1
