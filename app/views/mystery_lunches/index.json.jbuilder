json.mystery_lunches do |json|
  json.array! @mystery_lunches do |mystery_lunch|
    json.id mystery_lunch.id
    json.year_month mystery_lunch.year_month
    json.employees mystery_lunch.employees do |employee|            
      json.full_name employee.full_name
      json.picture employee.picture
      json.email employee.email
      json.department employee.department.name
    end  
  end  
end