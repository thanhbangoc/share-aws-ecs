import { Response } from 'express';

export function respondBadRequest(res: Response) {
  res.status(400).json({
    statusCode: 400,
    message: 'Bad Request',
  });
}

export function respondUnauthorized(res: Response) {
  res.status(401).json({
    statusCode: 401,
    message: 'Unauthorized',
  });
}

export function respondForbidden(res: Response) {
  res.status(403).json({
    statusCode: 403,
    message: 'Forbidden',
  });
}

export function respondNotFound(res: Response) {
  res.status(404).json({
    statusCode: 404,
    message: 'Not Found',
  });
}
