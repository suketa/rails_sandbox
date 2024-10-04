require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe '.age_over_or_equal_to' do
    before do
      FactoryBot.create(:employee, name: '社員名1', age: 29)
      FactoryBot.create(:employee, name: '社員名2', age: 30)
      FactoryBot.create(:employee, name: '社員名3', age: 31)
    end

    it '指定した年齢以上の社員を取得する' do
      result = Employee.age_over_or_equal_to(30)
      result = result.order(:name).map do |employee|
        [ employee.name, employee.age ]
      end
      expect(result).to eq [ [ '社員名2', 30 ], [ '社員名3', 31 ] ]
    end

    it '該当するデータがない場合は空のコレクションを返す' do
      result = Employee.age_over_or_equal_to(32)
      expect(result.count).to eq 0
      expect(result.map(&:name)).to be_empty
    end

    # 28歳以下の社員を取得する
    # 29歳以上の社員を取得する
    # 31歳以上の社員を取得する
    # のケースのテストもあった方がいいかも
  end

  describe '.in_project' do
    before do
      employee1 = FactoryBot.create(:employee, name: '社員名1', age: 29)
      employee2 = FactoryBot.create(:employee, name: '社員名2', age: 30)
      employee3 = FactoryBot.create(:employee, name: '社員名3', age: 31)
      project1 = FactoryBot.create(:project, name: 'プロジェクト名1')
      project2 = FactoryBot.create(:project, name: 'プロジェクト名2')
      FactoryBot.create(:assignment, employee: employee1, project: project1, role: '役職1')
      FactoryBot.create(:assignment, employee: employee2, project: project1, role: '役職2')
      FactoryBot.create(:assignment, employee: employee3, project: project2, role: '役職1')
      FactoryBot.create(:assignment, employee: employee1, project: project2, role: '役職2')
    end
    it '特定のプロジェクトに入っている社員を返す' do
      result = Employee.in_project('プロジェクト名1')
      result = result.order(:name).map(&:name)
      expect(result).to eq %w[社員名1 社員名2]
    end
  end

  describe '.having_role' do
    before do
      employee1 = FactoryBot.create(:employee, name: '社員名1', age: 29)
      employee2 = FactoryBot.create(:employee, name: '社員名2', age: 30)
      employee3 = FactoryBot.create(:employee, name: '社員名3', age: 31)
      project1 = FactoryBot.create(:project, name: 'プロジェクト名1')
      project2 = FactoryBot.create(:project, name: 'プロジェクト名2')
      FactoryBot.create(:assignment, employee: employee1, project: project1, role: '役職1')
      FactoryBot.create(:assignment, employee: employee2, project: project1, role: '役職2')
      FactoryBot.create(:assignment, employee: employee3, project: project2, role: '役職1')
      FactoryBot.create(:assignment, employee: employee1, project: project2, role: '役職2')
    end
    it '特定のプロジェクトに入っている社員を返す' do
      result = Employee.having_role('役職1')
      result = result.order(:name).map(&:name)
      expect(result).to eq %w[社員名1 社員名3]
    end
  end

  describe '.all_with_department_and_project' do
    before do
      department1 = FactoryBot.create(:department, name: '部署名1')
      department2 = FactoryBot.create(:department, name: '部署名2')
      employee1 = FactoryBot.create(:employee, name: '社員名1', age: 29, department: department1)
      employee2 = FactoryBot.create(:employee, name: '社員名2', age: 30, department: department1)
      employee3 = FactoryBot.create(:employee, name: '社員名3', age: 31, department: department2)
      employee4 = FactoryBot.create(:employee, name: '社員名4', age: 31, department: department2)
      project1 = FactoryBot.create(:project, name: 'プロジェクト名1')
      project2 = FactoryBot.create(:project, name: 'プロジェクト名2')
      FactoryBot.create(:assignment, employee: employee1, project: project1, role: '役職1')
      FactoryBot.create(:assignment, employee: employee2, project: project1, role: '役職2')
      FactoryBot.create(:assignment, employee: employee3, project: project2, role: '役職1')
      FactoryBot.create(:assignment, employee: employee1, project: project2, role: '役職2')
    end

    it '部署、プロジェクト情報を含めて全ての社員を取得する' do
      employees = Employee.all_with_department_and_project
      employees = employees.order(:name).map do |employee|
        [
          employee.name,
          employee.department.name,
          employee.assignments.map { |assignment| [ assignment.project.name, assignment.role ] }.sort_by { |assignment| assignment.first }
        ]
      end
      expect(employees).to eq [
        [ '社員名1', '部署名1', [ [ 'プロジェクト名1', '役職1' ], [ 'プロジェクト名2', '役職2' ] ] ],
        [ '社員名2', '部署名1', [ [ 'プロジェクト名1', '役職2' ] ] ],
        [ '社員名3', '部署名2', [ [ 'プロジェクト名2', '役職1' ] ] ],
        [ '社員名4', '部署名2', [] ]
      ]
    end
  end
end
