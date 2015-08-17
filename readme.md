# Rails API Testing Examples

## Step 1:

Get the Muppets app up and set up running locally:
https://github.com/benlcollins/rails_api_testing_examples/tree/master/muppets-api	

## Step 2: Writing tests with the Minitest framework

Minitest is the Rails built in testing framework.

Official documentation: http://guides.rubyonrails.org/testing.html

Look in your Rails app folder now and you can see the "test" folder with the following sub-folders:

- controllers (where we write tests for our controllers)
- fixtures (this is sample data for testing purposes)
- helpers (helper methods for tests)
- integration (where we write integration tests)
- mailers (for testing mailer functionality)
- models (where we write tests for our models)

Start by creating a new branch:

```
git checkout -b minitest_example
```

### Model testing

First, go to the muppet model: **app/models/muppet.rb** and comment out the two validation lines:

```ruby
class Muppet < ActiveRecord::Base
  # validates :name, presence: true
  # validates :image_url, presence: true
end
```

Create a test file for the muppets model: **test/models/muppet_model_test.rb**

Add code:
```ruby
require 'test_helper'

class MuppetTest < ActiveSupport::TestCase
	test "muppet should not save without a name" do
		muppet = Muppet.new(name: "", image_url: "image.jpg")
		assert_not muppet.save, "Saved muppet without a name"
	end

	test "muppet should not save without an image_url" do
		muppet = Muppet.new(name: "whatever", image_url: "")
		assert_not muppet.save, "Saved muppet without an image url"
	end
end
```

Then run this test from the command line with:
```
rake test
```

This test should fail! *assert_not* ensures that test is false, but because we removed validation the statement *muppet.save* was true, so the test failed.

```
FF
```

You should see two F's in your console and the two error messages we included, because at the moment you can save a muppet without a name or url. 

**Fix that by going back to your muppet model in the app folder and uncommenting the two validation lines.**

Run the test again and it should now pass. You should see two ".." and no error messages:

```
..
```

Try adding this code into test file:

```ruby
test "test not ready" do
	flunk("Test not ready yet. Still writing assertions.")
end
```

Now run the test in the command line again. Output:

```
..F
```

It fails because the flunk assertion always fails. Useful to signal to other developers that you're still working on this test. 

Comment out or delete the flunk test now.

Let's add a final test to ensure that muppets with all parameters do indeed save *(question - is this necessary? This test passes with or without validations)*:

```ruby
test "muppet should save with valid parameters" do
	muppet = Muppet.new(name: "Muppet Name", image_url: "image.jpg")
	assert muppet.valid?, "Muppet not valid without all parameters"
	assert_equal "Muppet Name", muppet.name, "The name of the muppets does not match!"
end
```

This should save with 3 runs and 4 assertions:

```
...
```

Try changing "Muppet Name" to "Kermit" in the "assert_equal" line...

### Controller Test

Create test file: **test/controllers/api_controller_test.rb**

Add outline code:
```ruby
require 'test_helper'
 
class ApiControllerTest < ActionController::TestCase
	test "should get success response after get request" do

	end
end
```

Run just this new test with: 

```
rake test test/controllers/api_controller_test.rb
```

Get the index page and add first assertion:

```ruby
get :index
assert_response :success	
```

Run to see the test pass. Asserts that the response comes with a specific status code, where **:success** indicates a 200-299 code was returned (see http://apidock.com/rails/Test/Unit/Assertions/assert_response).

Confirm that it's JSON being returned, add this assertion:

```ruby
test "it should return JSON" do 
	get :index, :format => :json
end
```

Run the controller test again. It should pass:

```
..
```

Now we want some seed data to use for testing, which we create with...

#### Fixtures

Fixtures are sample data for testing purposes. They are active record objects that we use to populate our testing database, stored in YAML files with .yml extensions.

Use spaces NOT tabs to indent in YAML file.

Create test/fixtures/muppets.yml

```yml
# test muppets
one:
	name: kermit
	image_url: kermit.jpg

two:
	name: gonzo
	image_url: gonzo.jpg
```

Back to controller test file, add code to test the get "show" action:

```ruby
test "get 'show' test" do
	get :show, :id => @one["id"]
	assert_response :success
	body = JSON.parse(response.body)
	assert_equal "kermit", body['name']
end
```

Lastly, test the post action:

```ruby
test "should add a new muppet with post action" do
  assert_difference('Muppet.count') do
    post :create, muppet: { name: "New Muppet", image_url: "New Muppet picture" }
  end
end
```

*The post create test is not working with this code - TBC*

Add binding.pry and review in terminal window

To finish, merge with master:

```
git add

git commit -m 'Add minitest framework test suite'

git checkout master

git merge minitest_example
```


## Step 3: Writing tests with the RSpec testing framework

RSpec is a popular third-party framework for testing that allows you to write readable tests.

http://rspec.info/documentation/

Again, start by creating a new branch:

```
git checkout -b rspec_example
```

### RSpec setup

RSpec is a testing framework for plain old Ruby applications. RSpec-rails extends RSpec so you can specify behaviour of your Rails app (https://github.com/dchelimsky/rspec/wiki/rails).

RSpec doesn’t ship with Rails so we have to add it to our Gemfile and then install it, by adding the rspec-rails gem to development and test environments (https://github.com/rspec/rspec-rails).

In Gemfile:

```
group :development, :test do
  gem 'rspec-rails', '~> 3.0'
end
```

Then

```
bundle install
```

Initialize the spec directory:

```
rails generate rspec:install
```

Notice the new spec folder has been created in our root directory.

### Model testing

Create a new folder and file for model tests: **spec/models/muppet_spec.rb**

Add the code for our muppet test:

```ruby
require 'rails_helper'

RSpec.describe Muppet, :type => :model do
	it "doesn't save without a valid name" do
		muppet = Muppet.new
		expect(muppet).not_to be_valid, "Muppet saved without a valid name"
	end
end
```

Comment out the name validation in muppet model and run model test

```
bundle exec rspec spec/models
```

This test FAILS at first, so uncomment out the name validation and the test should now pass.

```
.
```

Add code to test image_url validation.

And test that it saves muppet with valid attributes *(question - is this necessary?)*:

```ruby
it "saves with valid name and image_url" do
	muppet = Muppet.new(name: "muppet", image_url: "muppet.jpg")
	expect(muppet).to be_valid, "Muppet saved without a valid name and image_url"
end
```

### Controller testing

Create new folder and file for controller tests: **spec/controllers/api_controller_spec.rb**

Add code:

```ruby
require 'rails_helper'

RSpec.describe ApiController, :type => :controller do
	describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end
end
```

and run controller tests with:

```
bundle exec rspec spec/controllers
```

This test should pass:

```
.
```

Install Factory Girl gem (https://github.com/thoughtbot/factory_girl_rails) as a fixtures replacement, to create data for RSpec testing, and then test api endpoints.

```
gem 'factory_girl_rails'
```

and 

```
bundle install
```

then define a muppet class in **spec/factories.rb** and add code:

```ruby
FactoryGirl.define do

  factory :muppet

end
```

Then add code for returning muppets as JSON:

```ruby
it "returns all the muppets as JSON" do
	FactoryGirl.create :muppet, name: "gonzo", image_url: "gonzo.jpg"
	FactoryGirl.create :muppet, name: "kermit", image_url: "kermit.jpg"

	get :index, {}, { "Accept" => "application/json" }

	body = JSON.parse(response.body)
	muppet_names = body.map { |m| m["name"] }

	expect(muppet_names).to match_array(["gonzo","kermit"])

end
```

For SHOW, PUT and DELETE HTTP verbs, some ideas for tests in this post:
http://commandercoriander.net/blog/2014/01/04/test-driving-a-json-api-in-rails/


## Create better looking output formats in terminal

Look at https://github.com/kern/minitest-reporters

and https://www.railstutorial.org/book/static_pages#sec-minitest_reporters


## Further Resources:

http://buildingrails.com/a/rails_unit_testing_with_minitest_for_beginners
http://buildingrails.com/a/rails_functional_testing_controllers_for_beginners_part_1
http://commandercoriander.net/blog/2014/01/04/test-driving-a-json-api-in-rails/
http://matthewlehner.net/rails-api-testing-guidelines/
http://stackoverflow.com/questions/8282116/rails-how-to-unit-test-a-json-controller





