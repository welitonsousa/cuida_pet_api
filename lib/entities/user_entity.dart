class UserEntity {
  final int? id;
  final String email;
  final String registerType;
  final String? password;
  final String? photo;
  final String? iosToken;
  final String? androidToken;
  final String? refreshToken;
  final String? socialKey;
  final int? supplierId;

  UserEntity({
    this.id,
    required this.email,
    this.registerType = 'app',
    this.password,
    this.photo,
    this.iosToken,
    this.androidToken,
    this.refreshToken,
    this.socialKey,
    this.supplierId,
  });

  @override
  String toString() {
    return 'UserEntity(id: $id, email: $email, registerType: $registerType, password: $password, photo: $photo, iosToken: $iosToken, androidToken: $androidToken, refreshToken: $refreshToken, socialKey: $socialKey, supplierId: $supplierId)';
  }

  UserEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? registerType,
    String? password,
    String? photo,
    String? iosToken,
    String? androidToken,
    String? refreshToken,
    String? socialKey,
    int? supplierId,
  }) {
    var pass = this.password;
    if (password != null && password.isEmpty) pass = null;

    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      registerType: registerType ?? this.registerType,
      password: pass,
      photo: photo ?? this.photo,
      iosToken: iosToken ?? this.iosToken,
      androidToken: androidToken ?? this.androidToken,
      refreshToken: refreshToken ?? this.refreshToken,
      socialKey: socialKey ?? this.socialKey,
      supplierId: supplierId ?? this.supplierId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'email': email});
    result.addAll({'registerType': registerType});
    if (password != null) {
      result.addAll({'password': password});
    }
    if (photo != null) {
      result.addAll({'photo': photo});
    }
    if (iosToken != null) {
      result.addAll({'iosToken': iosToken});
    }
    if (androidToken != null) {
      result.addAll({'androidToken': androidToken});
    }
    if (refreshToken != null) {
      result.addAll({'refreshToken': refreshToken});
    }
    if (socialKey != null) {
      result.addAll({'socialKey': socialKey});
    }
    if (supplierId != null) {
      result.addAll({'supplierId': supplierId});
    }

    return result;
  }
}
