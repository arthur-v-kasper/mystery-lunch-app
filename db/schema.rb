# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_119_225_020) do
  create_table 'departments', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'employees', force: :cascade do |t|
    t.string 'full_name', null: false
    t.string 'picture'
    t.integer 'department_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'email', null: false
    t.integer 'inactivated'
    t.index ['department_id'], name: 'index_employees_on_department_id'
  end

  create_table 'mystery_lunch_employee_schedules', force: :cascade do |t|
    t.integer 'selected'
    t.integer 'employee_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['employee_id'], name: 'index_mystery_lunch_employee_schedules_on_employee_id'
  end

  create_table 'mystery_lunch_employees', force: :cascade do |t|
    t.integer 'employee_id', null: false
    t.integer 'mystery_lunch_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['employee_id'], name: 'index_mystery_lunch_employees_on_employee_id'
    t.index ['mystery_lunch_id'], name: 'index_mystery_lunch_employees_on_mystery_lunch_id'
  end

  create_table 'mystery_lunches', force: :cascade do |t|
    t.integer 'year_month', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'user_name', null: false
    t.string 'password_digest', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'employees', 'departments'
  add_foreign_key 'mystery_lunch_employee_schedules', 'employees'
  add_foreign_key 'mystery_lunch_employees', 'employees'
  add_foreign_key 'mystery_lunch_employees', 'mystery_lunches'
end
