class Event {
  String title;
  String description;
  String date;
  String imageUrl;

  Event({this.title, this.description, this.date, this.imageUrl});

  Event.fromSnapshot(Map<String, dynamic> json) {
    this.title = json['title'];
    this.description = json['description'];
    this.date = json['date'];
  }
}
