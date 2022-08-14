import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/register/social_register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cashe_helper.dart';
import 'package:social_app/layout/social_layout.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext contex)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (context,state)
        {
          if(state is SocialLoginErrorState)
          {
            showToast(
                text: state.error,
                state: ToastStates.error
            );
          }
         if(state is SocialLoginSucceedState)
         {
           CasheHelper.saveData(
               key: 'uId',
               value: state.uId
           ).then((value){
             navigateAndFinish(context, const SocialLayout());
           });
         }
        },
        builder:(context,state)
          {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:
                        [
                          const Text("LOGIN NOW",
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Login to get in touch with your friends !",
                            style: TextStyle(
                              fontSize:25,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                              label: "Email Adress",
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              prefix: Icons.email,
                              validate: (value)
                              {
                                if (value == null || value.isEmpty)
                                {
                                  return " Email can'ot be empty ";
                                }
                                return null;
                              }
                          ),
                          const SizedBox(
                            height: 20,),
                          defaultFormField(
                              label: "Password",
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              prefix: Icons.lock,
                              suffix: SocialLoginCubit.get(context).suffix,
                              isPasword:SocialLoginCubit.get(context).isPassword,
                              suffixPressed: ()
                              {
                                SocialLoginCubit.get(context).changePasswordVisibility();
                              },
                              validate: (value)
                              {
                                if (value == null || value.isEmpty)
                                {
                                  return " Password can't be empty ";
                                }
                                return null;
                              },
                            onSubmit:(value)
                            {
                              if(formKey.currentState!.validate())
                              {}
                            }
                          ),
                          const SizedBox(
                            height: 20,),
                          ConditionalBuilderRec(
                            condition: state is! SocialLoginLoadingState,
                            fallback:(context)=> const Center(child: CircularProgressIndicator()),
                            builder: (context)=>
                                defaultButton(
                                    text: "Login",
                                    function: ()
                                    {
                                      if(formKey.currentState!.validate())
                                      {
                                        SocialLoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text
                                        );
                                      }
                                    }
                                ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              const Text('Don\'t have an account ?'),
                              const SizedBox(
                                width: 2,
                              ),
                              defaultTextButton(
                                  text: "REGISTER NOW",
                                  function: ()
                                  {
                                    navigateTo(context, SocialRegisterScreen());
                                  }
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
      ),
    );
  }
}
