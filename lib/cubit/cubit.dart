// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/message_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/users_model.dart';
import '../layout/chats/chats_screen.dart';
import '../layout/feed/feeds_screen.dart';
import '../layout/new_post/new_post_screen.dart';
import '../layout/settings/settings_screen.dart';
import '../layout/users/users_screen.dart';
import '../shared/components/constant.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  void getUserData()
  {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value)
    {
    debugPrint(value.data().toString());
    userModel = SocialUserModel.fromJson(value.data()!);
    emit(SocialGetUserSuccsessState());
    }).catchError((onError)
    {
      debugPrint(onError.toString());
      emit(SocialGetUserErrorState(onError));
    });
  }

  int currentIndex = 0;
  List<Widget> screens =
  [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen()
  ];

  List<String> titles =
  [
    "Home",
    "Chats",
    "New Post",
    "Users",
    "Settings"
  ];

  void changeBottomNav (int index)
  {
    if(index==0)
      getPosts();
    if( index == 1)
      getUsers();
    if (index == 2)
    {
      emit(SocialNewPostState());
    }
    else
      {
        currentIndex = index;
        emit(SocialChangeBottomNavState());
      }

  }

  File? profileImage;
  final ImagePicker picker = ImagePicker();

  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }
    else
      {
        debugPrint("No Image Selected");
        emit(SocialProfileImagePickedErrorState());
      }

  }

  File? coverImage;
  Future<void> getCoverImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null)
    {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }
    else
    {
      debugPrint("No  Cover Image Selected");
      emit(SocialCoverImagePickedErrorState());
    }
  }

  /*void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
    String? image,
  })
  {
    firebase_storage
        .FirebaseStorage
        .instance
        .ref()
        .child("users/profile/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        updateUserData(
            name: name,
            phone: phone,
            bio: bio,
            image: value
        );
        emit(SocialUploadProfileImageSuccessState());
        debugPrint(value);
      }).catchError((onError)
      {
        emit(SocialUploadProfileImageErrorState());
      });
    })
        .catchError((onError)
    {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
    String? cover,
  })
  {
    firebase_storage
        .FirebaseStorage
        .instance
        .ref()
        .child("users/cover/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        updateUserData(
            name: name,
            phone: phone,
            bio: bio,
            cover: value
        );
        emit(SocialUploadCoverImageSuccessState());
        debugPrint(value);
      }).catchError((onError)
      {
        emit(SocialUploadCoverImageErrorState());
      });
    })
        .catchError((onError)
    {
      emit(SocialUploadCoverImageErrorState());
    });
  }*/

/*  void updateUserImages({
    required String name,
    required String phone,
    required String bio,
  })
  {
   emit(SocialUserUpdateLoadingState());
   if(coverImage != null)
   {
     uploadCoverImage();
   } else if (profileImage != null)
   {
      uploadProfileImage();
   }
   else
     {
       updateUserData(
           name: name,
           phone: phone,
           bio: bio
       );
     }
     }*/

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  })
  {
    emit(SocialUserUpdateLoadingState());
    SocialUserModel? model = SocialUserModel(
        name: name,
        phone: phone,
        bio: bio,
        email: userModel?.email,
        uId: userModel?.uId,
        image: image?? userModel?.image,
        cover: cover?? userModel?.cover,
        isEmailVerified: false
    );
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap()).then((value)
    {
      getUserData();
      emit(SocialUserUpdateSuccessState());
    }).catchError((onError)
    {
      debugPrint(onError.toString());
      emit(SocialUserUpdateErrorState());
    });
  }


  void updateUser({
    required String name,
    required String phone,
    required String bio,
  })
  {
    emit(SocialUserUpdateLoadingState());
    SocialUserModel? model = SocialUserModel(
        name: name,
        phone: phone,
        bio: bio,
        email: userModel?.email,
        uId: userModel?.uId,
        image: userModel?.image,
        cover: userModel?.cover,
        isEmailVerified: false
    );
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap()).then((value)
    {
      getUserData();
      emit(SocialUserUpdateSuccessState());
    }).catchError((onError)
    {
      debugPrint(onError.toString());
      emit(SocialUserUpdateErrorState());
    });
  }

  void uploadCover()
  {
    emit(SocialUploadImageLoadingState());
    firebase_storage
        .FirebaseStorage
        .instance
        .ref()
        .child("users/cover/${Uri.file(coverImage!.path).pathSegments.last}")
        .putFile(coverImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        SocialUserModel? model = SocialUserModel(
            name: userModel?.name,
            phone: userModel?.phone,
            bio:userModel?.bio,
            email: userModel?.email,
            uId: userModel?.uId,
            image:  userModel?.image,
            cover: value,
            isEmailVerified: false
        );
        FirebaseFirestore
            .instance
            .collection('users')
            .doc(userModel!.uId)
            .update(model.toMap()).then((value)
        {
          getUserData();
          emit(SocialUserUpdateSuccessState());
        }).catchError((onError)
        {
          debugPrint(onError.toString());
          emit(SocialUploadCoverImageErrorState());
        });
      }).catchError((onError)
      {
        debugPrint(onError.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((onError)
    {
      debugPrint(onError.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void uploadProfile()
  {
    emit(SocialUploadImageLoadingState());
    firebase_storage
        .FirebaseStorage
        .instance
        .ref()
        .child("users/profile/${Uri.file(profileImage!.path).pathSegments.last}")
        .putFile(profileImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        SocialUserModel? model = SocialUserModel(
            name: userModel?.name,
            phone: userModel?.phone,
            bio:userModel?.bio,
            email: userModel?.email,
            uId: userModel?.uId,
            image:  value,
            cover: userModel?.cover,
            isEmailVerified: false
        );
        FirebaseFirestore
            .instance
            .collection('users')
            .doc(userModel!.uId)
            .update(model.toMap()).then((value)
        {
          getUserData();
          emit(SocialUserUpdateSuccessState());
        }).catchError((onError)
        {
          emit(SocialUploadCoverImageErrorState());
          debugPrint(onError.toString());
        });
      }).catchError((onError)
      {
        debugPrint(onError.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((onError)
    {
      debugPrint(onError.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }



  File? postImage;
  Future<void> getPostImage() async
  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null)
    {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }
    else
    {
      debugPrint("No  Cover Image Selected");
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage()
  {
    postImage = null;
    emit(SocialPostImageRemovedState());
  }

  void createPost({
    required String? dateTime,
    required String? text,
    String? imagePost,
  })
  {
    emit(SocialCreatePostLoadingState());
    PostModel? model = PostModel(
        name: userModel?.name,
        uId: userModel?.uId,
        image: userModel?.image,
        dateTime: dateTime,
        text: text,
        postImage: imagePost??""
    );
    FirebaseFirestore.instance
        .collection("posts")
        .add(model.toMap())
        .then((value){
          emit(SocialCreatePostSuccessState());
          getPosts();
    }).catchError((onError){
          emit(SocialCreatePostErrorState());
          debugPrint(onError.toString());
    });

  }

  void createPostImage({
    required String? dateTime,
    required String? text,
})
  {
    emit(SocialCreatePostLoadingState());
    firebase_storage
        .FirebaseStorage
        .instance
        .ref()
        .child("posts/${Uri.file(postImage!.path).pathSegments.last}")
        .putFile(postImage!)
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        createPost(
            dateTime: dateTime,
            text: text,
            imagePost : value
        );
      }).catchError((onError)
      {
        debugPrint(onError.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((onError)
    {
      debugPrint(onError.toString());
      emit(SocialCreatePostErrorState());
    });
  }


  List<PostModel> posts = [];
  List<String> postsIds = [];
  List<int> likes = [];
  
  void getPosts()
  {
    // making the list empty to prvent dublicating the posts
    //List<PostModel> posts = [];
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection("posts")
        .get()
        .then((value)
    {
      for (var element in value.docs) {
        element.reference
            .collection("likes")
            .get()
            .then((value)
        {
          likes.add(value.docs.length);
          posts.add(PostModel.fromJson(element.data()));
          postsIds.add(element.id);
        }).catchError((onError){
          emit(SocialGetPostsErrorState(onError.toString()));
        });
        emit(SocialGetPostsSuccsessState());
      }
    }).catchError((onError){
      emit(SocialGetPostsErrorState(onError.toString()));
    });

  }

  List<SocialUserModel> users = [] ;
  void getUsers()
  {
    users=[];
    emit(SocialGetAlUsersLoadingState());
    FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((value){
          for (var element in value.docs) {
            if(element.data()['uId'] != userModel?.uId)
            users.add(SocialUserModel.fromJson(element.data()));
            emit(SocialGetAlUsersSuccsessState());
          }
    }).catchError((onError){
      emit(SocialGetAlUsersErrorState(onError.toString()));
    });

  }
  
  
  
/*  void getPosts()
  {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.
    collection("posts")
        .get()
        .then((value) {
          for (var element in value.docs)
          {
            element.reference
                .collection("likes")
                .get()
                .then((value)
            {
              likes.add(value.docs.length);
              posts.add(PostModel.fromJson(element.data()));
              postsIds.add(element.id);
            }).catchError((onError){

            });
          }

          emit(SocialGetPostsSuccsessState());
    }).catchError((onError)
    {
      emit(SocialGetPostsErrorState(onError.toString()));
    });
  }*/

  void likePost(String postId)
  {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(userModel?.uId)
        .set({
      "like": true
        }).then((value){
          emit(SocialPostLikeSuccsessState());
    }).catchError((onError){
      emit(SocialPostLikeErrorState(onError.toString()));
    });
  }
  void unLike (bool isLiked, String postId)
  {
    FirebaseFirestore.instance
        .collection("posts")
        .doc(postId)
        .collection("likes")
        .doc(userModel?.uId).set({
      "like" : isLiked
    }).then((value){}).catchError((onError){});
  }


  void sendMessage({
    required String receieverId,
    required String text,
    required String dateTime,
}){
    MessageModel model = MessageModel(
      senderId: userModel?.uId,
      receieverId: receieverId,
      text: text,
      dateTime: dateTime,
    );
    // put chats in my side
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receieverId)
        .collection("messages")
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError)
    {
      emit(SocialSendMessageErrorState());
    });
    //put chats in the receiever side
    FirebaseFirestore.instance
        .collection("users")
        .doc(receieverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection("messages")
        .add(model.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    }).catchError((onError)
    {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];
  void getMessages(String receiverId)
  {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel?.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event)
    {
      messages = [];
      for (var element in event.docs)
      {
        messages.add(MessageModel.fromJson(element.data()));
        emit(SocialGetMessagesSuccessState());
      }
    });
  }

}