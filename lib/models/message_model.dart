class MessageModel
{
  String? senderId;
  String? receieverId;
  String? dateTime;
  String? text;
  MessageModel({
    this.senderId,
    this.receieverId,
    this.dateTime,
    this.text,
  });


  MessageModel.fromJson(Map<String,dynamic>json)
  {
    senderId = json['senderId'];
    receieverId = json['receieverId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String,dynamic> toMap()
  {
    return
      {
        'senderId' : senderId,
        'receieverId' : receieverId,
        'dateTime' : dateTime,
        'text' : text,
      };
  }

}