# frozen_string_literal: true

ActiveRecord::Base.transaction do
  puts 'Creating departments...'
  department = %w[Operations Sales Marketing Risk Management Finance HR Development Data]
  department.each { |department| Department.create!(name: department) }

  puts 'Creating fake admin user...'
  def create_user(email)
    User.create!(user_name: email, password: 'fake-password')
  end

  puts 'Creating fake employees...'
  55.times do
    randomly_department = Department.find_by(name: department.sample)
    full_name = Faker::Name.name
    email = Faker::Internet.email(name: full_name,
                                  separators: '_', domain: 'creditshelf.com')
    user = create_user(email)

    Employee.create!(full_name:,
                     email:,
                     user:,
                     department: randomly_department)
  end

  puts 'Creating fake history mystery lunches (3 months)...'

  def create_mystery_lunch
    # (Time.now.months_ago(3)).strftime("%Y%m").to_i
    current_window = Time.now.strftime('%Y%m').to_i
    MysteryLunch.create!(year_month: current_window)
  end

  def pair_employee_mystery_lunch
    random_employees = MysteryLunchEmployeeSchedule.not_selected.sample(2)
    mystery_lunch = create_mystery_lunch
    # check_last_three_lunches(random_employees)
    random_employees.each do |random_employee|
      random_employee.selected!
      MysteryLunchEmployee.create!(mystery_lunch:,
                                   employee_id: random_employee.employee_id)
    end
  end

  def set_last_employee_mystery_lunch(last_employee)
    department_id = last_employee.employee.department.id
    mystery_lunch_diferent_departament(department_id)
  end

  def mystery_lunch_diferent_departament(department_id)
    MysteryLunchEmployee.joins(employee: :department)
                        .joins(:mystery_lunch)
                        .where('mystery_lunches.year_month = 202301')
                        .where("departments.id != #{department_id}")
                        .group('mystery_lunch_employees.mystery_lunch_id')
                        .having('COUNT(DISTINCT departments.id) > 1')
                        .select("mystery_lunch_employees.mystery_lunch_id,
                                COUNT(DISTINCT departments.id) as total_dep")
                        .first
  end
end
