import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import '../edit_profile/edit_profile_screen.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>
      (
      listener: (context,state){},
      builder: (context,state)
        {
          var userModel = SocialCubit.get(context).userModel!;
          return Padding(
            padding: const EdgeInsets.all(8.0),
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
                        child: Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)
                            ),
                            image: DecorationImage(
                              image:NetworkImage("${userModel.cover}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 53,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage("${userModel.image}"),
                          radius: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${userModel.name}",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 20),
                ),
                Text(
                  "${userModel.bio}",
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Row(
                    children:
                    [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                "Posts",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                "78",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                "Photos",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                "23",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                "Followers",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                "19K",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children:
                            [
                              Text(
                                "Followings",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              Text(
                                "371",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: (){},
                        ),
                      ),

                    ],),
                ),
                Row(
                  children:
                  [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: (){},
                          child: const Text("Add Photos")),
                    ),
                    const SizedBox(width: 10,),
                    OutlinedButton(
                        onPressed: ()
                        {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: const FaIcon(FontAwesomeIcons.penToSquare,
                        size: 20,
                        )
                    ),
                  ],)
              ],
            ),
          );
        },

       );
  }
}
