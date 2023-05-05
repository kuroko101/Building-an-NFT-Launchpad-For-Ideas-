fetch('/api/projects', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      name: 'My Project',
      description: 'This is my project',
      imageUrl: 'example.img',
      price: 10.99
    })
  })
  .then(response => response.json())
  .then(data => {
    console.log(data); // Handle response data
  })
  .catch(error => {
    console.error(error); // Handle errors
  });  