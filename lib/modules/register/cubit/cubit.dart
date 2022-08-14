import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/users_model.dart';
import 'states.dart';


class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super (SocialRegisterInitialState());
  static SocialRegisterCubit get(context)=> BlocProvider.of(context);

  void userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  })
  {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value){
      debugPrint(value.user!.email);
      debugPrint(value.user!.uid);
      userCreate(
          name: name,
          phone: phone,
          email: email,
          uId: value.user!.uid
      );
    }).catchError((onError){
      emit(SocialRegisterErrorState(onError.toString()));
    });
  }

  void userCreate({
    required String name,
    required String phone,
    required String email,
    required String uId,
  })
  {
    SocialUserModel userModel = SocialUserModel(
      uId: uId,
      email: email,
      name: name,
      phone: phone,
      image: "https://img.freepik.com/free-photo/cute-adorable-boy-studio_58702-7625.jpg?w=740&t=st=1659169711~exp=1659170311~hmac=b68eab57a957d763a0095514bc7ec3ad8308f305e74063d2f9bc67af197a87fb",
      bio: "Write your bio....",
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.
    collection('users').
    doc(uId).
    set(userModel.toMap()).then((value){
      emit(SocialCreateUserSucceedState());
    }).catchError((onError){
      emit(SocialCreateUserErrorState(onError.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ?  Icons.visibility_outlined : Icons.visibility_off;
    emit(SocialRegisterChangePasswordVisibilityState());
  }

}