import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/modules/social_login_screen/social_login_layout.dart';
import 'package:social_app/shared/components/components.dart';

import 'new_post/new_post_screen.dart';


class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state)
        {
          if (state is SocialNewPostState)
          {
            navigateTo(context, const NewPostScreen());
          }
        },
        builder: (context, state)
        {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              actions:
              [
                IconButton(
                    onPressed:() {},
                    icon: const Icon(Icons.notifications)
                ),
                IconButton(
                    onPressed:() {},
                    icon: const FaIcon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 20,
                    )
                ),
                IconButton(
                    onPressed:()
                    {
                      navigateTo(context, const SocialLoginScreen());
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.arrowRightFromBracket,
                      size: 20,
                    )
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index)
              {
                cubit.changeBottomNav(index);
              },
              currentIndex: cubit.currentIndex,
              items:
              const
              [
                BottomNavigationBarItem(
                    icon: FaIcon(
                        FontAwesomeIcons.house,
                        size: 20,
                    ),
                    label: "Home"
                ),
                BottomNavigationBarItem(
                    icon: FaIcon(
                        FontAwesomeIcons.rocketchat,
                        size: 20,
                    ) ,
                    label: "Chats"
                ),
                BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.plus,
                      size: 20,
                    ) ,
                    label: "Post"
                ),
                BottomNavigationBarItem(
                    icon: FaIcon(
                        FontAwesomeIcons.user,
                        size : 20
                    ),
                    label: "Users"
                ),
                BottomNavigationBarItem(
                    icon: FaIcon(
                        FontAwesomeIcons.s,
                        size : 20,
                    ),
                    label: "Settings"
                ),
              ],
            ),
          );
        },
    );
  }
}
