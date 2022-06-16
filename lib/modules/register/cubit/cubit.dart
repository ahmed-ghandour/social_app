import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super (SocialRegisterInitialState());
  static SocialRegisterCubit get(context)=> BlocProvider.of(context);
  //SocialLoginModel? registeredUser;
 /* void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  })
  {
    emit(SocialRegisterLoadingState());
    DioHelper.postData(
        url: register,
        data:
        {
          'name' : name,
          'phone' : phone,
          'email': email,
          'password' : password,
          'image': 'image',
        }
    ).then((value){
      registeredUser = SocialLoginModel.fromJson(value.data);
      emit(SocialRegisterSucceedState(registeredUser!));
    }).catchError((onError){
      emit(SocialRegisterErrorState(onError));
    });
  }*/
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ?  Icons.visibility_outlined : Icons.visibility_off;
    emit(SocialRegisterChangePasswordVisibilityState());
  }

}