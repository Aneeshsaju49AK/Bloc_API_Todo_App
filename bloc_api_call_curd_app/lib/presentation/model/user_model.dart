class UserModel {
  final String status;
  List<Data> data;
  UserModel({this.status = "NO-status", this.data = const []});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["message"],
        data: List<Data>.from(json['items'].map((json) => Data.fromJson(json)))
            .toList(),
      );
}

class Data {
  final String id;
  final String title;
  final String descripition;
  final bool isCompleted;

  Data({
    this.id = '_id',
    this.title = "title",
    this.descripition = "descripition",
    this.isCompleted = false,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['_id'],
        title: json["title"],
        descripition: json["description"],
        isCompleted: json["is_completed"],
      );
}
