import 'package:cuida_pet_api/application/database/i_database_config.dart';
import 'package:cuida_pet_api/dtos/supplier_near_by_my_dto.dart';
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
}
