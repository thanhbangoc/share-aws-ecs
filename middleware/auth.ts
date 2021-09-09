import { Request, Response, NextFunction } from 'express';
import * as jwt from 'jsonwebtoken';

import {
  respondUnauthorized,
  respondBadRequest,
} from '../services/shared/commonResponses';
import { extractToken } from '../services/shared/utils';

export function auth(req: Request, res: Response, next: NextFunction) {
  try {
    const authorizationHeader = req.headers.authorization;

    if (!authorizationHeader) {
      return respondUnauthorized(res);
    }

    const token: string = extractToken(authorizationHeader);

    // TODO: validate token
    const decodedToken = jwt.decode(token);
    if (token) {
      next();
    }
  } catch (error) {
    // TODO: handle error
    // tslint:disable-next-line:no-console
    console.log('ERROR!!!');

    respondBadRequest(res);
  }
}
