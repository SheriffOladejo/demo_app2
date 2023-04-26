class Message {

  int id;
  int timestamp;
  String message;
  String groupDate;
  String recipientNumber;
  String recipientName;
  String sender;
  bool isSelected = false;

  Message({
    this.id,
    this.message,
    this.timestamp,
    this.groupDate,
    this.recipientNumber,
    this.recipientName,
    this.sender,
    this.isSelected,
  });

}