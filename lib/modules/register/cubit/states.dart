

abstract class SocialRegisterStates{}

class SocialRegisterInitialState extends SocialRegisterStates{}

class SocialRegisterLoadingState extends SocialRegisterStates{}

class SocialRegisterSucceedState extends SocialRegisterStates
{

}

class SocialRegisterErrorState extends SocialRegisterStates
{
  final dynamic error;

  SocialRegisterErrorState(this.error);

}
class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates{}
