import 'package:cuida_pet_api/application/database/i_database_config.dart';
import 'package:cuida_pet_api/application/excptions/service_exception.dart';
import 'package:cuida_pet_api/dtos/supplier_near_by_my_dto.dart';
import 'package:cuida_pet_api/entities/supplier_entity.dart';
import 'package:cuida_pet_api/entities/supplier_service_entity.dart';
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
          f.categorias_fornecedor_id,
          c.nome_categoria,
          c.tipo_categoria,
          ST_X(f.latlng) lat,
          ST_Y(f.latlng) lng
        """,
        where: 'f.id=$id and c.id=f.categorias_fornecedor_id',
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
      throw Exception('Erro ao registrar fornecedor');
    } finally {
      await conn.close();
    }
  }

  @override
  Future<SupplierServiceEntity> createService({
    required String name,
    required double value,
    required int supplierId,
  }) async {
    final conn = _database.openConnection();
    try {
      final res = await conn.insert(
        table: 'fornecedor_servicos',
        insertData: {
          'nome_servico': name,
          'valor_servico': value,
          'fornecedor_id': supplierId,
        },
      );
      return SupplierServiceEntity(
          id: res, name: name, value: value, supplierId: supplierId);
    } finally {
      await conn.close();
    }
  }

  @override
  Future<void> deleteService(int supplierId, int serviceId) async {
    final conn = _database.openConnection();
    try {
      final res = await conn.delete(
        table: 'fornecedor_servicos',
        where: {
          'fornecedor_id': supplierId,
          'id': serviceId,
        },
      );
      if (res <= 0) throw ServiceNotExistesException();
    } catch (e) {
      throw Exception('Erro ao atualizar serviço');
    } finally {
      await conn.close();
    }
  }

  @override
  Future<SupplierServiceEntity> updateService(
    SupplierServiceEntity entity,
  ) async {
    final conn = _database.openConnection();
    try {
      final res = await conn.update(
        table: 'fornecedor_servicos',
        updateData: {
          'nome_servico': entity.name,
          'valor_servico': entity.value,
        },
        where: {
          'fornecedor_id': entity.supplierId,
          'id': entity.id,
        },
      );

      if (res <= 0) {
        final count = await conn.count(table: 'fornecedor_servicos', where: {
          'fornecedor_id': entity.supplierId,
          'id': entity.id,
        });
        if (count == 0) throw ServiceNotExistesException();
      }
      return entity;
    } finally {
      await conn.close();
    }
  }

  @override
  Future<List<SupplierServiceEntity>> getService(int supplierId) async {
    final conn = _database.openConnection();
    try {
      final res = await conn.getAll(table: 'fornecedor_servicos', where: {
        'fornecedor_id': supplierId,
      });
      print(res);
      return res.map(SupplierServiceEntity.fromMap).toList();
    } finally {
      await conn.close();
    }
  }

  @override
  Future<SupplierEntity> updateSupplier(SupplierEntity entity) async {
    final conn = _database.openConnection();
    try {
      print(entity);
      await conn.update(
        table: 'fornecedor',
        updateData: {
          if (entity.name.isNotEmpty) 'nome': entity.name,
          if (entity.phone != null) 'telefone': entity.phone,
          if (entity.address != null) 'endereco': entity.address,
          if (entity.logo != null) 'logo': entity.logo,
          if (entity.category.id != 0)
            'categorias_fornecedor_id': entity.category.id,
        },
        where: {'id': entity.id},
      );
      if (entity.lat != null && entity.lng != null) {
        await conn.query(
            "UPDATE fornecedor SET latlng = ST_GeomFromText('POINT(${entity.lat} ${entity.lng})') WHERE id = ${entity.id}");
      }
      final supplier = await findById(entity.id);
      return supplier;
    } finally {
      await conn.close();
    }
  }
}
