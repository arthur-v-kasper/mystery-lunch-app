# frozen_string_literal: true

# json.departments do |json|
json.array! @departments do |department|
  json.id department.id
  json.name department.name
end
# end
