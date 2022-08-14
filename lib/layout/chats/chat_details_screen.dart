import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/users_model.dart';
import 'package:social_app/shared/styles/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel? userModel;
  const ChatDetailsScreen({Key? key,this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    var messageController = TextEditingController();

    return Builder(builder: (BuildContext context)
    {

      return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state) {},
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              title: Row(
                children:
                [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("${userModel?.image}"),
                  ),
                  const SizedBox(
                    width: 10,),
                  Text("${userModel?.name}")
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(
                top: 0.0,
                left: 10.0,
                right: 10.0,
                bottom: 10.0
              ),
              child: Column(
                children:
                [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      child: ListView.separated(
                        padding: const EdgeInsets.only(
                            bottom: 4),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,index)
                          {
                            var message = SocialCubit.get(context).messages[index];
                            if(SocialCubit.get(context).userModel?.uId == message.senderId)
                            {
                              return buildMyMessage(message);
                            }
                            else {
                              return buildMessage(message);
                            }
                          },
                        separatorBuilder: (context,index)=> const SizedBox(height: 15,),
                        itemCount: SocialCubit.get(context).messages.length
                      ),
                    ),
                  ),
                  Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey.withOpacity(.3),
                          width: 1
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children:
                      [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              controller: messageController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "type your message here",
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: defaultColor,
                          height: 55,
                          child: MaterialButton(
                            onPressed: ()
                            {
                              SocialCubit.get(context).sendMessage(
                                  receieverId: userModel!.uId!,
                                  text: messageController.text,
                                  dateTime: DateTime.now().toString()
                              );
                              messageController.clear();
                            },
                            minWidth: 1,
                            child: const Icon(
                              Icons.send,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

    });
  }

  buildMessage(MessageModel messageModel) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.3),
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10),
          child: Text("${messageModel.text}"),
        )),
  );
  buildMyMessage( MessageModel messageModel ) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
        decoration: BoxDecoration(
            color: defaultColor.withOpacity(.4),
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(20),
              topEnd: Radius.circular(20),
              bottomStart: Radius.circular(20),
              bottomEnd: Radius.circular(20),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10),
          child: Text(messageModel.text!),
        )),
  );
}


