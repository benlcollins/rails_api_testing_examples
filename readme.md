# Rails API Testing Examples

## Step 1:

Get the Muppets app up and running locally:
https://github.com/benlcollins/rails_api_testing_examples/tree/master/muppets-api

## Step 2: Using the Minitest framework

Minitest is the Rails built in testing framework.

Look in your Rails app folder now and you can see at "test" folder with the following sub-folders:

- controllers (where we write tests for our controllers)
- fixtures (this is sample data for testing purposes)
- helpers (helper methods for tests)
- integration (where we write integration tests)
- mailers (for testing mailer functionality)
- models (where we write tests for our models)

Start by creating a new branch:

git checkout -b minitest_example