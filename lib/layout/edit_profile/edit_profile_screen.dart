import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import '../../shared/components/components.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:(context,sstate)
      {
        var userModel = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = userModel?.name as String;
        bioController.text = userModel?.bio as String;
        phoneController.text = userModel?.phone as String;
        return Scaffold(
          appBar:
          defaultAppBar(
              context: context,
              actions:
              [
                defaultTextButton(
                    text: "Update",
                    function: ()
                    {
                      SocialCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text
                      );
                    }
                ),
                const SizedBox(width: 15,)
              ],
              title: const Text("Edit Profile")
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children:
                [
                  SizedBox(
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children:
                            [
                              Container(
                                width: double.infinity,
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(5)
                                  ),
                                  image: DecorationImage(
                                    image: coverImage == null ? NetworkImage("${userModel?.cover}") : FileImage(coverImage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 20,
                                  child: IconButton(
                                    onPressed: ()
                                    {
                                      SocialCubit.get(context).getCoverImage();
                                    },
                                    icon: const FaIcon(
                                      FontAwesomeIcons.camera,
                                      size: 19,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 53,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                backgroundImage: profileImage == null ? NetworkImage("${userModel?.image}") : FileImage(profileImage) as ImageProvider ,
                                radius: 50,
                              ),
                            ),
                            CircleAvatar(
                              radius: 15,
                              child: IconButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.camera,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  if(SocialCubit.get(context).profileImage != null || SocialCubit.get(context).coverImage!= null)...
                  [
                    Row(
                      children: [
                  if(SocialCubit.get(context).profileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  text: "Update Profile",
                                  function: ()
                                  {
                                    SocialCubit.get(context).uploadProfile();
                                  }
                              ),
                              if(State is SocialUploadImageLoadingState)
                                const SizedBox(height: 5,),
                              if(State is SocialUploadImageLoadingState)
                                const LinearProgressIndicator(),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5 ,),
                  if(SocialCubit.get(context).coverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  text: "Update Cover",
                                  function: ()
                                  {
                                    SocialCubit.get(context).uploadCover();
                                  },
                              ),
                              if(State is SocialGetUserSuccsessState)...
                              <Widget>[
                                const SizedBox(height: 5,),
                                const LinearProgressIndicator(),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                  ],
                  defaultFormField(
                      label: "Name",
                      controller: nameController,
                      prefix: FontAwesomeIcons.user,
                      validate: (String? value)
                      {
                        if(value == null || value.isEmpty)
                        {
                          return'Name must be not empty';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 10,),
                  defaultFormField(
                      label: "Bio",
                      controller: bioController,
                      prefix: FontAwesomeIcons.info,
                      validate: (String? value)
                      {
                        if(value ==null || value.isEmpty)
                        {
                          return'Bio must be not empty';
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 10,),
                  defaultFormField(
                      label: "Phone",
                      controller: phoneController,
                      prefix: FontAwesomeIcons.phone,
                      validate: (String? value)
                      {
                        if(value ==null || value.isEmpty)
                        {
                          return'Phone must be not empty';
                        }
                        return null;
                      }
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
