import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social_login_screen/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super (SocialLoginInitialState());
  static SocialLoginCubit get(context)=> BlocProvider.of(context);
  //late SocialLoginModel loginModel;
/*  void userLogin({
    required String email,
    required String password
})
  {
    emit(SocialLoginSLoadingState());
    DioHelper.postData(
        url: login,
        data:
        {
          'email': email,
          'password' : password
        }
    ).then((value){
      loginModel = SocialLoginModel.fromJson(value.data);
      emit(SocialLoginSucceedState(loginModel));
    }).catchError((onError){
      emit(SocialLoginErrorState(onError));
    });
  }*/
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ?  Icons.visibility_outlined : Icons.visibility_off;
    emit(SocialChangePasswordVisibilityState());
  }

}