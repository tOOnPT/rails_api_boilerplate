# :sparkles: rails_api_boilerplate.rb

**Important**

Change the *Project Name*

Search about `rails_api_boilerplate` and replace it where it"s needed.
Don"t forget about the folder name too. ;)

#### Dependencies
* [Ruby *2.6.3*](https://www.ruby-lang.org/en/documentation/installation/)
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

And the security verification report
```bash
$ open coverage/brakeman/index.html
```

On commit creation:
- insert a "good" message
- rubocop & rspec will run to make sure everything is good

Git hooks are defined on the `hooks` folder.

#### API Documentation
We will use [*rswag*](https://github.com/domaindrivendev/rswag) for this.

**How it works?**
In the `spec/integrations` folder you can see one example. In this case is about the healthcheck endpoint.
Rswag makes use of integration tests that we write about our endpoints to generate the documentations.
This was the why I liked and started to use it.

So, follow the `/spec/integration/healthcheck_spec.rb` and start to write new ones about new endpoints that you create.
Don't foget to check the Rswag documentation on github to know more about it.

When ready, just do:
```bash
$ ./bin/swaggerize
```

This will update the swagger json so, just open the path `.../api-docs` and check the documentation.

### DB Diagram

Every time you do `rails db:migrate` a DB diagram will be built.
You can see the diagram on the pdf that was placed on the root folder of the project.

#### Versioning
TBD

#### Services (job queues, cache servers, search engines, etc.)
TBD

#### Continuous Integration
TBD

#### :rocket: Deployment instructions
Lets use Capistranofor deploys.
It simple gets one branch code from the project repository and
send it to the selected environment (machine).
```bash
cap <env_name> deploy
```
The `env_name` can be `staging` or `production`.
For the selection of the branch it will ask you to type in the name of it.


#### Thank _You_!

Help spread the **code quality** ***word***! :heart:
