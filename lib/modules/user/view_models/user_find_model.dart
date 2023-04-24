class UserFindModel {
  final int id;
  UserFindModel({required this.id});

  factory UserFindModel.fromMap(Map<String, dynamic> map) {
    return UserFindModel(
      id: map['id']?.toInt() ?? 0,
    );
  }
}
