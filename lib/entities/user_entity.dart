class UserEntity {
  final int? id;
  final String? email;
  final String? registerType;
  final String? password;
  final String? photo;
  final String? iosToken;
  final String? androidToken;
  final String? refreshToken;
  final String? socialKey;
  final int? supplierId;

  UserEntity({
    this.id,
    this.email,
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
    return {
      'id': id,
      'email': email,
      'register_type': registerType,
      'photo': photo,
      'ios_token': iosToken,
      'android_token': androidToken,
      // 'refresh_token': refreshToken,
      'social_key': socialKey,
      'supplier_id': supplierId,
    };
  }

  factory UserEntity.fromMap(map) {
    return UserEntity(
      id: map['id'],
      email: map['email'],
      password: map['senha'],
      registerType: map['tipo_cadastro'],
      iosToken: map['ios_token'],
      androidToken: map['android_token'],
      refreshToken: map['refresh_token'],
      photo: map['img_avatar'],
      socialKey: map['social_id'],
      supplierId: map['fornecedor_id'],
    );
  }
}
