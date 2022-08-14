import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/users_model.dart';
import 'package:social_app/shared/components/components.dart';

import 'chat_details_screen.dart';


class ChatsScreen extends StatelessWidget
{
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return ConditionalBuilderRec(
          condition: SocialCubit.get(context).users.isNotEmpty,
          builder: (context)=>ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context,index)=> buildChatItem(context,SocialCubit.get(context).users[index]),//SocialCubit.get(context).users[index]
              separatorBuilder: (context,index)=> dividerBuilder(),
              itemCount: SocialCubit.get(context).users.length
          ),
          fallback: (context)=> const Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }
  Widget buildChatItem (context,SocialUserModel? userModel)=> InkWell(
    onTap: ()
    {
      navigateTo(context, ChatDetailsScreen(userModel:userModel));
      SocialCubit.get(context).getMessages(userModel!.uId!);
    },
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          CircleAvatar(
            backgroundImage: NetworkImage("${userModel?.image}"),
            radius: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Row(
                  children:
                  [
                    Text("${userModel?.name}",
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(height: 1.4),
                    ),
                  ],),
                Text("Test Mode",
                  style: Theme.of(context).textTheme.caption?.copyWith(height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
