const http = require('http');
const port = process.env.PORT || 3000;


const requestHandler = (request, response) => {
  response.end('Hello from ECS Fargate!');
};

const server = http.createServer(requestHandler);
server.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
