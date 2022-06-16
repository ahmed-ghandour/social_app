import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context )=> SocialRegisterCubit(),
        child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (context,state)
        {
         /* if ( state is SocialRegisterSucceedState)
          {
            if (state.loginModel.status!)
            {
              CasheHelper.saveData(
                  key: "token",
                  value: state.loginModel.data!.token
              ).then((value){
                token = state.loginModel.data!.token;
                print(state.loginModel.data!.token.toString());
                navigateAndFinish(context, const SocialLayout());
                //goToHomeLayoutScreen();
              });
            }
            else
            {
              showToast(
                  text: state.loginModel.message!,
                  state: ToastStates.error);
            }
          }*/
        },
        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      Text('Register',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text('Register to communicate with your friends .......',
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(height: 20,
                      ),
                      defaultFormField(
                          label: 'User Name',
                          type: TextInputType.name,
                          controller: nameController,
                          prefix: Icons.person,
                          validate: (value)
                          {
                            if ( value == null || value.isEmpty)
                            {
                              return 'Name Can not be Empty ';
                            }
                          }
                      ),
                      const SizedBox(
                        height: 20,),
                      defaultFormField(
                          label: 'Email Address',
                          type: TextInputType.emailAddress,
                          controller: emailController,
                          prefix: Icons.email_outlined,
                          validate: (value)
                          {
                            if ( value == null || value.isEmpty)
                            {
                              return 'Email Can not be Empty ';
                            }
                          }
                      ),
                      const SizedBox(height: 20,
                      ),
                      defaultFormField(
                          label: 'Phone',
                          type: TextInputType.phone,
                          controller: phoneController,
                          prefix: Icons.phone,
                          validate: (value)
                          {
                            if ( value == null || value.isEmpty)
                            {
                              return 'Phone Can not be Empty ';
                            }
                          }
                      ),
                      const SizedBox(height: 20,
                      ),
                      defaultFormField(
                          label: 'Password',
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          isPasword: SocialRegisterCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            SocialRegisterCubit.get(context).changePasswordVisibility();
                          },
/*                          onSubmit: (value)
                          {
                            if (formKey.currentState!.validate())
                            {
                              SocialRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },*/
                          validate: (value)
                          {
                            if (value == null || value.isEmpty )
                            {
                              return ' Password Can not be Empty  ';
                            }
                          }
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                ConditionalBuilderRec(
                  condition: state is! SocialRegisterLoadingState,
                  builder: (context)=> defaultButton(
                      text: "Register",
                      function: ()
                      {
                        if (formKey.currentState!.validate())
                        {
                          /*SocialRegisterCubit.get(context).userRegister(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phone: phoneController.text,
                          );*/
                        }
                      } ),
                  fallback: (context)=> const Center(child: CircularProgressIndicator()),
                ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
    ));
  }
}
