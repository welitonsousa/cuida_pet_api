enum Method {
  GET,
  POST,
  PUT,
  DELETE;

  static Method fromMethod(String method) {
    return Method.values.singleWhere((e) => e.name == method.toUpperCase());
  }
}

class SkipModel {
  final String path;
  final List<Method> methods;

  SkipModel({required this.path, required this.methods});

  @override
  int get hashCode => path.hashCode ^ methods.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SkipModel &&
        other.path == path &&
        methods.toSet().intersection(other.methods.toSet()).isNotEmpty;
  }
}
