Event.create(account_id: 1, kind: 1, occurred_at: Time.zone.now)
Event.create(account_id: 2, kind: 2, occurred_at: Time.zone.now)
Event.create(account_id: 3, kind: 3, occurred_at: Time.zone.now) # => Partition が存在しないためエラーが発生する。
# Event.safe_create(account_id: 3, kind: 3, occurred_at: Time.zone.now) # => Partition が作成されてからレコードが作成される。
Event.safe_create(account_id: 1, kind: 2, occurred_at: Time.zone.now)
Event.safe_create(account_id: 3, kind: 2, occurred_at: Time.zone.now)
