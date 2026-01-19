export type UserRole = 'admin' | 'user';

export interface UserPublicMetadata {
  role?: UserRole;
}

declare global {
  interface CustomJwtSessionClaims {
    publicMetadata: UserPublicMetadata;
  }
}