import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'models/base_model.dart';

abstract class JsonModel {
  String toJson();
}

abstract class LocalRepository<T> {
  Future<T?> get();
  Future<T> save(T model);
  Future<void> delete();
}

class LocalRepositoryImpl<X extends JsonModel> extends LocalRepository<X> {
  LocalRepositoryImpl({
    required this.storage,
    required this.baseModel,
    this.defaultValue,
  });

  final FlutterSecureStorage storage;
  final GetJsonBaseModel baseModel;

  String? defaultValue;
  final _key = 'key:$X';

  @override
  Future<X?> get() async {
    final storeData = await storage.read(key: _key);
    if (storeData?.isNotEmpty == true) {
      return baseModel(storeData!);
    } else if (defaultValue?.isNotEmpty == true) {
      return baseModel(defaultValue!);
    }
    return null;
  }

  @override
  Future<X> save(X model) async {
    await storage.write(key: _key, value: model.toJson());
    return model;
  }

  @override
  Future<void> delete() {
    return storage.delete(key: _key);
  }
}
