# Mystery lunch App - Arthur Valentim Kasper

Hey Guys, all right?

Below is some information about the project. =]

it was done using:

```
ruby 3.1.2
rails 7.0.4
react 18.2.0
```

In addition, some additional gems and libs were used, which were as follows:

### Backend

- [Faker](https://github.com/faker-ruby/faker) to generate data for the tests
- [Jbuilder](https://github.com/rails/jbuilder) to serialize the API
- [RSpec](https://github.com/rspec/rspec-rails) to build the tests
- [Shoulda matchers](https://matchers.shoulda.io/) to write one-liner tests
- [Factorybot](https://github.com/thoughtbot/factory_bot) to create fake active records to tests
- [Whenever](https://github.com/javan/whenever) to cron jobs

### Frontend

- [MUI](https://mui.com/) for friendly components
- [React Query](https://react-query-v3.tanstack.com/) to fetch requestes

_How I used SQLite, I didn't use docker for this project_

## Running the project

After clone the project, run:

```
bundle install
```

To load the fake data run:

```
rails db:reset
```

This will create the database based on existing migrations after finished it will print output like that:
:

```
Dropped database 'db/development.sqlite3'
Dropped database 'db/test.sqlite3'
Created database 'db/development.sqlite3'
Created database 'db/test.sqlite3'
Creating departments...
Creating fake admin user...
Creating fake employees...
Creating fake mystery lunches for 202211...
Creating fake mystery lunches for 202212...
Creating fake mystery lunches for 202301...
Creating fake mystery lunches for 202302...
```

start APIs and frontend

```
./bin/dev
```

Access the app

```
http://localhost:3000/
```

default credentials

```
user: admin@creditshelf.com
password: fakepassword
```

Start cron job

```
crontab -r
whenever --update-crontab --set environment='development'
```

run the tests

```
rspec
```

```
yarn jest test
```

## About the project

It was made using Rails for backend and React for frontend, let's talk about each part, starting with the back end, as it is more complex and covers most of the project.

# Backend

### ER Model

Below is an image of the database modeling and an explanation about each table and its responsibility
![](/img/er.png)

- **Department**: Departments of creditshelf.
- **Employees**: Employees of creditshelf, that has a relation with departments.
- **Mystery Lunches**: This table has records that represent the mystery lunches, one record is one mystery lunch to a specific period (Year Month), that can have two or three employees.
- **Mystery Lunch Employees**: This table has the employees of a mystery lunch, so here its have an association with the mystery_lunches table and employees.
- **Mystery Lunch Employee Schedules**: This table is used to manage employees who have already had a mystery lunch scheduled.
- **Users**: Admin user that can manager the employees.

---

### Services

The main logic to handle with the business rules are in the service folder:

![](/img/service_folder.png)

I tried to keep the name of the services very straightforward to make it easier to understand, so I create a namespace for each responsibility.

The `fake_data` sub-folder is where fake data are loaded (When running `rails db:reset`) to test the app, each file is responsible to a part, as seen in the picture.

The `manager_lunch` follow the same logic, I created one service for each part used to manage the mystery lunches

---

### Controllers

In the controllers was created the APIs that will be consumed by the frontend, very straightforward as well.

![](/img/controllers_folder.png)

### Cron Job

In the `schedule.rb` has the cron job that will create new mystery lunch for all employees following the rules, every first day of the month, in case of the period already had data, the creation don't happen

# Frontend

In the frontend there are folders to:

- Components, that are used in the app (It's a SPA).
- Context, the file that have the provider and the custom hook to manager the global context.
- helpers, have a file with a javascript function.
- services, have a file that wrap the functions used to fetch the data from API.

# How the APP works

The first tab lists all the Mystery Lunches from the current Year Month, and you can see the previous mystery lunches changed year month ate the select component, above the list.

![](/img/app1.png)

The Employee tab lists all the employees filtered by department.

![](/img/app2.png)

As could see above, it's necessary to log in to manage the employees, so if click on login e enter with credentials, it's possible manage the employees

And all the action of employee management triggers another action follow the rules of the project.

## Notes
I know that I was late to finish the project, and these are some points that I ended up not being able to implement that I would like to:
  - Uploading images
  - More tests (Mainly on the frontend)
  - additional feature

Well guys, I hope that you enjoy this, see you!

![](https://media.giphy.com/media/ASd0Ukj0y3qMM/giphy.gif)
