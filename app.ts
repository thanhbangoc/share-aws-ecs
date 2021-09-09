import * as dotenv from 'dotenv';
import * as express from 'express';
import * as http from 'http';

import { router as indexRouter } from './api/index';

dotenv.config();

const app = express();

const port = +process.env.PORT || 3000;
app.set('port', port);

const server = http.createServer(app);
server.listen(port);
server.on('listening', () => {
  const address = server.address();
  const bind =
    typeof address === 'string' ? `pipe ${address}` : `port ${address.port}`;

  // tslint:disable-next-line:no-console
  console.log(`Listening on ${bind}`);
});

app.use('/', indexRouter);
