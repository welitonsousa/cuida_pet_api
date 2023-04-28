import 'package:cuida_pet_api/application/database/i_database_config.dart';
import 'package:cuida_pet_api/dtos/supplier_near_by_my_dto.dart';
import 'package:cuida_pet_api/entities/supplier_entity.dart';
import 'package:cuida_pet_api/modules/supplier/data/i_supplier_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ISupplierRepository)
class SupplierRepository extends ISupplierRepository {
  final IDataBaseConfig _database;

  SupplierRepository(this._database);

  @override
  Future<List<SupplierNearByMyDto>> findNearByPosition(
      double lat, double lng, double distance) async {
    final conn = _database.openConnection();
    try {
      final query = """
      SELECT f.id, f.nome, f.logo, f. categorias_fornecedor_id, 
        (6371* 
          ACOS(
            COS(RADIANS($lat)) *
            COS(RADIANS(ST_X(f.latlng))) *
            COS(RADIANS($lng) - RADIANS(ST_Y(f.latlng))) +
            SIN(RADIANS($lat)) * SIN(RADIANS(ST_X(f.latlng)))
          )) AS distancia
        FROM fornecedor f
        HAVING distancia <= $distance;
      """;
      final res = await conn.query(query);
      return res.rows.map(SupplierNearByMyDto.fromMap).toList();
    } finally {
      await conn.close();
    }
  }

  @override
  Future<SupplierEntity> findById(int id) async {
    final conn = _database.openConnection();
    try {
      final res = await conn.getOne(
        table: 'fornecedor f,categorias_fornecedor c',
        fields: """
          f.id,
          f.nome,
          f.logo,
          f.endereco,
          f.telefone,
          c.id categoria_fornecedor_id,
          c.nome_categoria,
          c.tipo_categoria,
          ST_X(f.latlng) lat,
          ST_Y(f.latlng) lng
        """,
        where: 'f.id=$id',
      );
      return SupplierEntity.fromMap(res);
    } finally {
      await conn.close();
    }
  }

  @override
  Future<bool> userExistes(String email) async {
    final conn = _database.openConnection();
    try {
      final res = await conn.count(
        table: 'usuario',
        where: {'email': email},
      );
      return res > 0;
    } finally {
      await conn.close();
    }
  }

  @override
  Future<int> registerSupplier({
    required String name,
    required String phone,
    required int categoryId,
  }) async {
    final conn = _database.openConnection();
    try {
      final res = await conn.insert(table: 'fornecedor', insertData: {
        'nome': name,
        'telefone': phone,
        'categorias_fornecedor_id': categoryId,
      });
      return res;
    } catch (e) {
      print(e);
      throw Exception('Erro ao registrar fornecedor');
    } finally {
      await conn.close();
    }
  }
}
