# rails_api_boilerplate.rb

**Important**

Search about `rails_api_boilerplate` and replace it where it"s needed.
Don"t forget about the folder name too. ;)

#### Dependencies
* [Ruby *2.4.2*](https://www.ruby-lang.org/en/documentation/installation/)
* [Rails *5.1.4*](http://rubyonrails.org)
* [PostgreSQL *10.1*](https://www.postgresql.org)

#### Configuration
```bash
$ ./bin/setup
```

**Important**

Don"t forget to follow the `.env_example` to build your `.env`.

#### Start the server
```bash
$ rails s (default port number: 3000)
$ rails s -p <port number>
```

#####
Try it:
```bash
curl localhost:3000
```

#### Tests
```bash
$ bundle exec rspec spec/<path to file>_spec.rb (run a spec)
$ ./bin/test (run the test suite)
```

**Important**

The test suite script needs to have execution permission.
To give it use this:
```bash
$ chmod +x bin/test
```

#### Quality
> Coverage ...% is below the expected minimum coverage (100.00%, why not?!).

Run the test suite and open the coverage index file
```bash
$ open coverage/index.html
```

Git hooks are defined on the `hooks` folder.

#### API Documentation
Don"t forget, write your documentation, [wiki](...).

#### Services (job queues, cache servers, search engines, etc.)
...

#### Deployment instructions
Lets use Capistranofor deploys.
It simple gets one branch code from the project repository and
send it to the selected environment (machine).
```bash
cap <env_name> deploy
```
The `env_name` can be `staging` or `production`.
For the selection of the branch it will ask you to type in the name of it.
