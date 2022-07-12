# {{ POST }} {{ /artists }} Route Design Recipe

_Copy this design recipe template to test-drive a Sinatra route._

## 1. Design the Route Signature
## 1.1 - First route
You'll need to include:
  * the HTTP method: POST
  * the path:  /ARTISTS
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

# With body parameters:
name=Wild nothing
genre=Indie

# Expected response (200 OK)
(No content)

## 1.2 Second Route

You'll need to include:
  * the HTTP method: GET
  * the path:  /ARTISTS
  * any query parameters (passed in the URL)
  * or body parameters (passed in the request body)

# With body parameters:

# Expected response (200 OK)
Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wild nothing

## 2. Design the Response

The route might return different responses, depending on the result.

For example, a route for a specific blog post (by its ID) might return `200 OK` if the post exists, but `404 Not Found` if the post is not found in the database.

Your response might return plain text, JSON, or HTML code. 

_Replace the below with your own design. Think of all the different possible responses your route will return._

```html
<!-- EXAMPLE -->
<!-- Response when the post is found: 200 OK -->


## 3. Write Examples

_Replace these with your own design._

```
# Request:

POST /artists

# Expected response:

1. Response for 200 OK

# Request:

GET /artists

# Expected response:

1. Response for 200 OK
2. Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wild nothing

```

## 4. Encode as Tests Examples

```ruby
# EXAMPLE
# file: spec/integration/application_spec.rb

require "spec_helper"

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }
    #checking if the artist was created

  context "POST /artists" do
    it 'returns 200 OK, creates an artist and return the total of artists' do 
      response = post('/artists)
      expect(response.status).to eq(200)
      expect(response.body). to eq('')
    end
  end

  context "GET /artists" do
    it 'returns 200 OK and the correct content' do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wilde nothing"
    end
  end
end
```

## 5. Implement the Route

Write the route and web server code to implement the route behaviour.
