import * as express from 'express';
import { respondNotFound } from '../services/shared/commonResponses';
import { auth } from '../middleware/auth';

const router = express.Router();

router.get('/', (req, res, next) => {
  res.send('Hello World');
});

// TODO: Test auth middleware. Should be removed later
router.get('/unauthorized', auth, (req, res) => {
  res.send('Hello World');
});

router.get('*', (req, res) => {
  respondNotFound(res);
});

export { router };
