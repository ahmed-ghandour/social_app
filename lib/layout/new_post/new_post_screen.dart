import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';

import '../../shared/styles/colors.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    var textController = TextEditingController();
    var now = DateTime.now();


    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (contexr,state){},
      builder: (contexr,state)
      {
        return Scaffold(
          appBar: defaultAppBar(
              context: context,
              title: const Text("Create Post"),
              actions:
              [
                defaultTextButton(
                    text: "Post",
                    function: ()
                    {
                      if (SocialCubit.get(context).postImage == null)
                      {
                        SocialCubit.get(context).createPost(
                            dateTime: now.toString(),
                            text: textController.text
                        );
                      }
                      else
                        {
                          SocialCubit.get(context).createPostImage(
                              dateTime: now.toString(),
                              text: textController.text
                          );
                        }
                    }
                ),
              ]
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:
              [
                if (State is SocialCreatePostLoadingState)
                  ...<Widget>[
                  const LinearProgressIndicator(),
                  const SizedBox(height: 10,)
                ],
                Row(
                  children:
                  [
                    const CircleAvatar(
                      backgroundImage: NetworkImage("https://img.freepik.com/free-photo/cute-adorable-boy-studio_58702-7635.jpg?w=740&t=st=1659855338~exp=1659855938~hmac=ced7d3dc60826eb69ec62f331c714c0c5d2904804930ba6839ab622e7bdd4ff8"),
                      radius: 25,
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
                              Text("Zahra Mohamed",
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(height: 1.4),
                              ),
                              const SizedBox(width: 5,),
                              const Icon(
                                Icons.check_circle,
                                size: 15,
                                color: defaultColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: "What is in your mind ....",
                      border: InputBorder.none
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage != null)...<Widget>
                [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children:
                      [
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)
                            ),
                            image: DecorationImage(
                              image: FileImage(SocialCubit.get(context).postImage!),
                              fit: BoxFit.fitHeight,
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
                                SocialCubit.get(context).removePostImage();
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.xmark,
                                size: 19,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                Row(
                  children:
                  [
                    Expanded(
                      child: TextButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            const [
                              Icon(FontAwesomeIcons.image,),
                              SizedBox(width: 5,),
                              Text("Add Photos"),
                            ],
                          )
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            const [
                              Text("#Tags"),
                            ],
                          )
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

