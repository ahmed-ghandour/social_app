abstract class SocialLoginStates{}

class SocialLoginInitialState extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}

class SocialLoginSucceedState extends SocialLoginStates {}

class SocialLoginErrorState extends SocialLoginStates
{
  final dynamic error;

  SocialLoginErrorState(this.error);

}
class SocialChangePasswordVisibilityState extends SocialLoginStates{}
