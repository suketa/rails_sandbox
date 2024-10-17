require 'rails_helper'

RSpec.describe Department, type: :model do
  describe '.count_employees' do
    before do
      department1 = FactoryBot.create(:department, name: '部署名1')
      department2 = FactoryBot.create(:department, name: '部署名2')
      department3 = FactoryBot.create(:department, name: '部署名3')
      FactoryBot.create(:employee, name: '社員名1', department: department1)
      FactoryBot.create(:employee, name: '社員名2', department: department2)
      FactoryBot.create(:employee, name: '社員名3', department: department1)
    end

    it '部署ID, 部署名, 部署に所属する社員数 の配列を取得する' do
      result = Department.count_employees

      result = result.order(:id).map { |department| [ department.id, department.name, department.employee_nums ] }
      ids = Department.order(:id).map(&:id)
      expect(result).to eq [ [ ids.first, '部署名1', 2 ], [ ids.second, '部署名2', 1 ], [ ids.third, '部署名3', 0 ] ]
    end
  end
end
