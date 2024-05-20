# Dog Breed Pics README

## Objective

The objective of this project is to demonstrate the ability to create a simple web application using Ruby on Rails,
Tailwind CSS, and asynchronous form submissions. The application allows users to enter a dog breed name and fetch a
random image of that breed from the Dog CEO API.

## Features

- A web form with a text input field labeled "Breed" and a "Submit" button.
- Asynchronous form submission to fetch and display a dog breed image without a full page reload.
- Autocomplete suggestions for dog breeds as the user types.

## Technologies Used

- Ruby on Rails
- Tailwind CSS
- Turbo (for asynchronous form submission and updates)
- Stimulus (for handling autocomplete suggestions)
- WebMock and Minitest (for testing)

## Deployment URL

<a href="https://george-dog-pics.fly.dev/" target="_blank">https://george-dog-pics.fly.dev/</a>

## Usage

1. Enter a dog breed name in the "Breed" text field.
2. As you type, autocomplete suggestions will appear below the input field.
3. Click on a suggestion or finish typing the breed name and click "Submit".
4. A random image of the specified breed will be fetched from the Dog CEO API and displayed along with the breed name.

## Running Tests

1. Run the automated tests:
    ```sh
    bin/rails test:system
    ```

## Relevant Files

- [`test/system/dogs_test.rb`](test/system/dogs_test.rb): System tests for the application.
- [`app/controllers/dogs_controller.rb`](app/controllers/dogs_controller.rb): Handles the form submission and breed suggestions.
- [`app/views/dogs/breeds.turbo_stream.erb`](app/views/dogs/breeds.turbo_stream.erb): Turbo Stream view for asynchronously updating the breed suggestions.
- [`app/views/dogs/fetch_dog_image.turbo_stream.erb`](app/views/dogs/fetch_dog_image.turbo_stream.erb): Turbo Stream view for asynchronously updating the image and message.
- [`app/views/dogs/index.html.erb`](app/views/dogs/index.html.erb): Main view with the form and result display.
- [`app/javascript/controllers/autocomplete_controller.js`](app/javascript/controllers/autocomplete_controller.js): Stimulus controller for handling autocomplete suggestions.

## Additional Notes

- The autocomplete feature suggests breeds based on the input provided by the user, fetching data from the Dog CEO API.
- The form submission and breed suggestions are handled asynchronously using Turbo Streams.
- Automated tests cover various scenarios, including valid and invalid breed inputs, case insensitivity, and leading/trailing whitespace.

## Potential Improvements

- **Switch from POST to GET:** Since fetching an image based on the breed is an idempotent operation, switching from POST to GET would be more appropriate. This would also allow the URL to reflect the search query, making it easier to share and bookmark.
- **Dynamic URLs:** Add the image URL to the query parameters so that if the page is refreshed, the same image is displayed instead of a new random image. THis would be useful for sharing.
- **Input Validation and Error Handling:** Improve input validation and error handling to make the application more robust.
- **Clear search input button:** Button to clear the search input.
- **General UI Design and Accessibility Improvements:** Improve the design of the UI to make it more engaging and accessible.
- **Misspelled Breed Correction:** Implement a feature to suggest the correct breed if the user enters a misspelled breed name.
- **Keyboard Navigation for Autocomplete:** Enhance the autocomplete feature to support keyboard navigation, allowing users to select suggestions using the arrow keys and enter key.
- **Auto-Submit on Suggestion Selection:** Automatically submit the form when a breed is selected from the autocomplete suggestions.
- **Test Suite Improvements:** As the application grows, extract tests into separate controller, model, and view tests to improve build time and maintainability.
- **Continuous Integration and Deployment:** Set up continuous integration / deployment.
