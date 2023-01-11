# frozen_string_literal: true

ActiveRecord::Base.transaction do
  department = %w[Operations Sales Marketing Risk Management Finance HR Development Data]
  department.each { |department| Department.create!(name: department) }

  def create_user(email)
    User.create!(user_name: email, password: 'fake-password')
  end

  103.times do
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
end
