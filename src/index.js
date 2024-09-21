import cors from 'cors';
import express from 'express';

const app = express();

app.use(cors());

app.use((req, res, next) => {
  res.header('X-User-Language', req.get('X-User-Language'));
  next();
});

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(3000, () =>
  console.log(`Example app listening on port 3000!`),
);