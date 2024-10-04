# README

```
bin/rails g model Department name
bin/rails g model Project name start_date:date
bin/rails g model Employee name age:integer department:references
bin/rails g model Assignment employee:references project:references role
```

```
bin/rails db:create db:migrate
```

```
bin/rails c
Department.create([{name: '第１セクション'}, {name: '第２セクション'}])
Project.create([{name: 'Project1', start_date: '2024/04/01'}, {name: 'Project2', start_date: '2024/05/31'}])
Employee.create(name: '青崎', age: 31, department: Department.first)
Employee.create(name: '笠井', age: 29, department: Department.second)
Employee.create(name: '青田', age: 30, department: Department.first)
Assignment.create(employee: Employee.first, project: Project.first, role: 'PM')
Assignment.create(employee: Employee.second, project: Project.first, role: 'PL')
Assignment.create(employee: Employee.first, project: Project.second, role: 'PL')
Assignment.create(employee: Employee.third, project: Project.second, role: 'SE')
```

```
Employee.where(age: [30..])
Employee.joins(assignments: [:project]).where(projects: {name: 'Project1'})
# or `Employee.joins(:projects).where(projects: {name: 'Project1'})` when using `has_many :projects, through: :assignments` in Employee model.
Employee.joins(:assignments).where(assignments: {role: 'PL'})
Department.joins(:employees).select(:name,  "count(*)").group(:id)
Employee.eager_load(:department, assignments:[:project]).
```



