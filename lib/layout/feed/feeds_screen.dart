import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/shared/styles/colors.dart';

import '../../models/post_model.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<SocialCubit,SocialStates>
      (
        listener: (context, state) {},
        builder: (context, state)
        {
          return ConditionalBuilderRec(
            condition: SocialCubit.get(context).posts.isNotEmpty && SocialCubit.get(context).userModel != null,
            builder: (context)=> SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children:
                  [
                    ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context,index)=>buildPostItem(context,SocialCubit.get(context).posts[index],index),
                        separatorBuilder: (context,index)=> const SizedBox(height: 5,),
                        itemCount: SocialCubit.get(context).posts.length
                    )
                  ],
                ),
              ),
            ),
            fallback: (contexr)=>const Center(child: CircularProgressIndicator()),
          );
        }
      );
  }
  Widget buildPostItem(context, PostModel? postModel,index)=> Card(
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Row(
            children:
            [
              CircleAvatar(
                backgroundImage: NetworkImage("${postModel?.image}"),
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
                        Text("${postModel?.name}",
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(height: 1.4),
                        ),
                         const SizedBox(width: 5,),
                         const Icon(
                          Icons.check_circle,
                          size: 15,
                          color: defaultColor,
                        )
                      ],),
                    Text("${postModel?.dateTime}",
                      style: Theme.of(context).textTheme.caption?.copyWith(height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: (){},
                  icon:  Icon(
                    Icons.more_horiz,
                    color: Colors.grey[600],
                  )
              )
            ],
          ),
          const SizedBox(height: 5,),
          Text("${postModel?.text}",
            style: Theme.of(context).textTheme.bodyText1?.copyWith(letterSpacing: .4,height: 1.4),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                children:
                [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 2.0),
                    child: SizedBox(
                      height: 25,
                      child: MaterialButton(
                        onPressed: (){},
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        child: Text("#Software",
                            style:Theme.of(context).textTheme.caption?.copyWith(color: defaultColor) ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end:2.0),
                    child: SizedBox(
                      height: 25,
                      child: MaterialButton(
                        onPressed: (){},
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        child: Text("#Software_development",
                            style:Theme.of(context).textTheme.caption?.copyWith(color: defaultColor) ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end:2.0),
                    child: SizedBox(
                      height: 25,
                      child: MaterialButton(
                        onPressed: (){},
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        child: Text("#Flutter",
                            style:Theme.of(context).textTheme.caption?.copyWith(color: defaultColor) ),
                      ),
                    ),
                  ),
                ],),
            ),
          ),
          if(postModel?.postImage!="")
            Container(
            width: double.infinity,
            height: 180,
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image:NetworkImage("${postModel?.postImage}"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children:
            [
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children:
                      [
                        const FaIcon(
                          FontAwesomeIcons.heart,
                          size: 17,
                          color: Colors.red,),
                        const SizedBox(width: 5,),
                        Text("${SocialCubit.get(context).likes[index]} like",style: Theme.of(context).textTheme.caption,)
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: (){},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:
                      [
                        const FaIcon(
                          FontAwesomeIcons.rocketchat,
                          size: 17,
                          color: Colors.amber,),
                        const SizedBox(width: 5,),
                        Text("0 comment",style: Theme.of(context).textTheme.caption,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 5.0),
            child: Container(
              height: 1,
              color: Colors.grey[200],
            ),
          ),
          Row(
            children:
            [
              Expanded(
                flex: 4,
                child: InkWell(
                  onTap: (){},
                  child: Row(
                    children:
                    [
                       CircleAvatar(
                        backgroundImage: NetworkImage("${SocialCubit.get(context).userModel?.image}"),
                        radius: 15,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("Write a Comment ...",
                        style: Theme.of(context).textTheme.caption?.copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: ()
                  {
                    SocialCubit.get(context).likePost(SocialCubit.get(context).postsIds[index]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      const FaIcon(
                        FontAwesomeIcons.heart,
                        size: 14,
                        color: Colors.red,),
                      const SizedBox(width: 5,),
                      Text(
                        "like",
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                    [
                      FaIcon(
                        FontAwesomeIcons.share,
                        size: 14,
                        color: Colors.teal[600],),
                      const SizedBox(width: 5,),
                      Text(
                        "share",
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
