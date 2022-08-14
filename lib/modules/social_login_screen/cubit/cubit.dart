import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_login_screen/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super (SocialLoginInitialState());
  static SocialLoginCubit get(context)=> BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password
})
  {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      debugPrint(value.user!.displayName);
      debugPrint(value.user!.phoneNumber);
      emit(SocialLoginSucceedState(value.user!.uid));
    }).catchError((onError){
      emit(SocialLoginErrorState(onError.toString()));
    });
  }
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ?  Icons.visibility_outlined : Icons.visibility_off;
    emit(SocialChangePasswordVisibilityState());
  }

}