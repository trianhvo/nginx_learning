import cors from 'cors';
import express from 'express';
import path from 'path';

const app = express();

app.use(cors());

// Serve static files from the "public" directory
app.use(express.static(path.join(__dirname, 'public')));

app.use((req, res, next) => {
  res.header('X-User-Language', req.get('X-User-Language'));
  next();
});

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.listen(3000, '0.0.0.0', () =>
  console.log(`Example app listening on port 3000!`)
);
