# Rails API Testing Examples

## Step 1:

Get the Muppets app up and running locally:
https://github.com/benlcollins/rails_api_testing_examples/tree/master/muppets-api

## Step 2: Using the Minitest framework

Minitest is the Rails built in testing framework.

Official documentation: http://guides.rubyonrails.org/testing.html

Look in your Rails app folder now and you can see at "test" folder with the following sub-folders:

- controllers (where we write tests for our controllers)
- fixtures (this is sample data for testing purposes)
- helpers (helper methods for tests)
- integration (where we write integration tests)
- mailers (for testing mailer functionality)
- models (where we write tests for our models)

Start by creating a new branch:

```git
git checkout -b minitest_example
```

### Model testing

First, go to the muppet model: app/models/muppet.rb and comment out the two validation lines:

```ruby
class Muppet < ActiveRecord::Base
  # validates :name, presence: true
  # validates :image_url, presence: true
end
```

Create a test file for the muppets model: test/models/muppet_model_test.rb

Add code:
```ruby
require 'test_helper'

class MuppetTest < ActiveSupport::TestCase
	test "muppet should not save without a name" do
		muppet = Muppet.new(name: "", image_url: "whatever.com/")
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

This test should fail! 

You should see two F's in your console and the two error messages we included, because at the moment you can save a muppet without a name or url. Fix that by going back to your muppet model in the app folder and uncommenting the two validation lines.

Run the test again and it should now pass. You should see two ".." and no error messages.

Try adding this code into test file:

```ruby
test "test not ready" do
	flunk("Test not ready yet. Still writing assertions.")
end
```

Now run the test in the command line again. Output:

..F

It fails because the flunk assertion always fails. Useful to signal to other developers that you're still working on this test. 

Comment out or delete the flunk test now.

Let's add a final test to ensure that muppets with all parameters do indeed save:

```ruby
test "muppet should save with valid parameters" do
	muppet = Muppet.new(name: "Muppet Name", image_url: "muppet_images.com/")
	assert muppet.valid?, "Muppet not valid without all parameters"
	assert_equal "Muppet Name", muppet.name, "The name of the muppets does not match!"
end
```

This should save with 3 runs and 4 assertions "..."

Try changing muppet's name to "Kermit"...

### Controller Test

Create test file: test/controllers/api_controller_test.rb

Add outline code:
```ruby
require 'test_helper'
 
class ApiControllerTest < ActionController::TestCase
	test "should get success response after get request" do

	end
end
```

Run just this new test with: "rake test test/controllers/api_controller_test.rb"

Get the index page and add first assertion:

```ruby
get :index
assert_response :success	
```

Run to see the test pass. Asserts that the response comes with a specific status code, where :success indicates 200-299 code returned (see http://apidock.com/rails/Test/Unit/Assertions/assert_response).

Confirm that it's JSON being returned, add this assertion:

```ruby
test "it should return JSON" do 
	get :index, :format => :json
end
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

* the post create is not working with this code *

Add binding.pry and review in terminal window


## Step 3: RSpec testing framework




## Resources:

http://buildingrails.com/a/rails_unit_testing_with_minitest_for_beginners
http://buildingrails.com/a/rails_functional_testing_controllers_for_beginners_part_1
http://commandercoriander.net/blog/2014/01/04/test-driving-a-json-api-in-rails/
http://matthewlehner.net/rails-api-testing-guidelines/
https://coderwall.com/p/t39nmw/minitest-testing-json-apis (only for the ":format => :json" code)
http://stackoverflow.com/questions/8282116/rails-how-to-unit-test-a-json-controller





