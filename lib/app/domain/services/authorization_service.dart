abstract interface class AuthorizationService {
  void setBearer(String token);

  void removeBearer();
}
