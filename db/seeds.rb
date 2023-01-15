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

  def quantity_employees_not_selected
    MysteryLunchEmployeeSchedule.not_selected.count
  end

  def create_mystery_lunch(year_month)
    MysteryLunch.create!(year_month:)
  end

  def create_mystery_lunch_employees(mystery_lunch_id, employee_id)
    MysteryLunchEmployeeSchedule.find_by(employee_id:).selected!
    MysteryLunchEmployee.create!(mystery_lunch_id:, employee_id:)
  end

  def check_last_three_lunches(employees)    
    MysteryLunchEmployee.joins(:mystery_lunch)
    .where("mystery_lunches.year_month >= ? AND mystery_lunch_employees.employee_id IN (?)", 
           MysteryLunch::THREE_YEARMONTHS_AGO, employees.pluck(:employee_id))
    .group("mystery_lunches.year_month")
    .having("COUNT(DISTINCT mystery_lunch_id) = 1")
    .pluck("mystery_lunches.year_month")
  end

  def pair_employee_mystery_lunch(year_month)
    random_employees = get_random_employees
    mystery_lunch = create_mystery_lunch(year_month)
    random_employees.each do |random_employee|
      create_mystery_lunch_employees(mystery_lunch.id,
                                     random_employee.employee_id)
    end
  end

  def get_random_employees
    random_employees = []
    loop do
      random_employees = MysteryLunchEmployeeSchedule.not_selected.sample(2)
      result = check_last_three_lunches(random_employees)
      break if result.blank?
    end
    random_employees
  end

  def set_last_employee_mystery_lunch(year_month)
    last_employee = MysteryLunchEmployeeSchedule.not_selected.first
    department_id = last_employee.employee.department.id
    mystery_lunch = mystery_lunch_diferent_departament(department_id, year_month)    
    create_mystery_lunch_employees(mystery_lunch.mystery_lunch_id,
                                   last_employee.employee.id)
  end

  def mystery_lunch_diferent_departament(department_id, year_month)
    MysteryLunchEmployee.joins(employee: :department).joins(:mystery_lunch)
                        .where("mystery_lunches.year_month = #{year_month}")
                        .where("departments.id != #{department_id}")
                        .group('mystery_lunch_employees.mystery_lunch_id')
                        .having('COUNT(DISTINCT departments.id) > 1')
                        .select('mystery_lunch_employees.mystery_lunch_id')
                        .first
  end

  past_months = 3
  past_year_months = []
  while past_months > -1 do
    past_year_months << (Time.now.months_ago(past_months)).strftime("%Y%m").to_i
    past_months -= 1
  end  

  past_year_months.each do |year_month|
    puts "Creating fake mystery lunches for #{year_month}..."    
    loop do      
      pair_employee_mystery_lunch(year_month)
  
      set_last_employee_mystery_lunch(year_month) if quantity_employees_not_selected == 1
  
      if quantity_employees_not_selected == 0
        MysteryLunchEmployeeSchedule.unselect_all!
        break 
      end
    end
  end
end

# select ml.year_month  from mystery_lunch_employees mle
#  join mystery_lunches ml ON ml.id = mle.mystery_lunch_id and ml.year_month >= 202210 
# WHERE mle.employee_id in (64, 54)
# GROUP by ml.year_month
# HAVING count(DISTINCT mle.mystery_lunch_id) = 1
