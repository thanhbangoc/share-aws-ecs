export function extractToken(authorizationHeader: string) {
  const matches = authorizationHeader.match(
    /([A-Za-z0-9-_=]+\.[A-Za-z0-9-_=]+\.?[A-Za-z0-9-_.+/=]*$)/,
  );

  return matches ? matches[0] : '';
}
