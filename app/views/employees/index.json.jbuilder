# frozen_string_literal: true

json.employees do |json|
  json.array! @employees do |employee|
    json.id employee.id
    json.full_name employee.full_name
    json.email employee.email
    json.department employee.department.name
  end
end
