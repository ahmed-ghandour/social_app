abstract class SocialStates{}
class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}
class SocialGetUserSuccsessState extends SocialStates{}
class SocialGetUserErrorState extends SocialStates
{
  final dynamic error;

  SocialGetUserErrorState(this.error);
}

class SocialGetPostsLoadingState extends SocialStates{}
class SocialGetPostsSuccsessState extends SocialStates{}
class SocialGetPostsErrorState extends SocialStates
{
  final dynamic error;

  SocialGetPostsErrorState(this.error);
}

class SocialPostLikeSuccsessState extends SocialStates{}
class SocialPostLikeErrorState extends SocialStates
{
  final dynamic error;

  SocialPostLikeErrorState(this.error);
}

class SocialGetAlUsersLoadingState extends SocialStates{}
class SocialGetAlUsersSuccsessState extends SocialStates{}
class SocialGetAlUsersErrorState extends SocialStates
{
  final dynamic error;

  SocialGetAlUsersErrorState(this.error);
}
class SocialChangeBottomNavState extends SocialStates{}
class SocialNewPostState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}
class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}
class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUploadProfileImageSuccessState extends SocialStates{}
class SocialUploadProfileImageErrorState extends SocialStates{}

class SocialUploadImageLoadingState extends SocialStates{}

class SocialUploadCoverImageSuccessState extends SocialStates{}
class SocialUploadCoverImageErrorState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}
class SocialUserUpdateSuccessState extends SocialStates{}
class SocialUserUpdateLoadingState extends SocialStates{}

// Create Post
class SocialCreatePostErrorState extends SocialStates{}
class SocialCreatePostSuccessState extends SocialStates{}
class SocialCreatePostLoadingState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}
class SocialPostImagePickedErrorState extends SocialStates{}

class SocialPostImageRemovedState extends SocialStates{}

//Chat
class SocialSendMessageSuccessState extends SocialStates{}
class SocialSendMessageErrorState extends SocialStates{}

class SocialGetMessageErrorState extends SocialStates{}
class SocialGetMessageSuccessState extends SocialStates{}

class SocialGetMessagesSuccessState extends SocialStates{}