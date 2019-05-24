require 'rails_helper'

RSpec.describe 'try to use unfreeze_time' do
  context 'when using freeze_time and unfreeze_time' do
    before :each do
      freeze_time
    end
    after :each do
      unfreeze_time
    end
    it 'time freezed' do
      t1 = Time.zone.now
      sleep 1
      expect(Time.zone.now).to eq t1
    end
  end
  context 'when without freeze_time and unfreeze_time' do
    it 'time not freezed' do
      t1 = Time.zone.now
      sleep 1
      expect(Time.zone.now).to be > t1
    end
  end
end
