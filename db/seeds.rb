p ActiveJob::Base.queue_adapter
user = User.create(name: 'Taro')
user.avatar.attach(io: File.open(Rails.root.join('db/seeds/fixtures/gang.png')), filename: 'gang.png')
