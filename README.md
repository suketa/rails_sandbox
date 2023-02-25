# Rails Sandbox

This project is sandbox for trying new features of Rails
check branches

## How to run


```
$ git clone -b key_generator_hash_digest_class
$ env POSTGRES_USER=xxxx POSTGRES_PASSWORD=yyyy docker-compose up -d
$ docker-compose exec web bash
$ bin/rails db:create db:migrate
$ bin/rails s -b 0.0.0.0
```

- access http://localhost:3000/users
- reload page

Then you can see cookie and session values

- stop rails by Ctrl+C in web console

- `git checkout key_generator_hash_digest_rails7` in the host console

```
$ bundle install
$ bin/rails s -b 0.0.0.0
```

- access http://localhost:3000/users

Then signed cookie and crypted cookie values are gone.

- stop rails by Ctrl+C in web console

- `git checkout -` in the host console

```
$ bin/rails s -b 0.0.0.0
```

- access http://localhost:3000/users
- reload page

- stop rails by Ctrl+C in web console

- `git checkout key_generator_hash_digest_rails7_rotator` in the host console

```
$ bin/rails s -b 0.0.0.0
```

- access http://localhost:3000/users

Then you can see all values.
