// Get form element and add event listener
const form = document.querySelector('form');
form.addEventListener('submit', handleSubmit);

// Handle form submission
function handleSubmit(event) {
  event.preventDefault(); // prevent default form behavior

  // Get input values
  const name = document.querySelector('#name').value;
  const email = document.querySelector('#email').value;
  const message = document.querySelector('#message').value;

  // Do something with input values
  console.log(`Name: ${name}`);
  console.log(`Email: ${email}`);
  console.log(`Message: ${message}`);

  // Clear form inputs
  form.reset();
}