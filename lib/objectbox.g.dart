// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'qr_code.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(2, 7150627851134822972),
      name: 'MyQrCode',
      lastPropertyId: const IdUid(5, 7361502613210851233),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4079110495124208999),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3221145886699280980),
            name: 'content',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3260790833444664130),
            name: 'type',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 8775889634522824979),
            name: 'pcr',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7361502613210851233),
            name: 'date',
            type: 10,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(2, 7150627851134822972),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [5111790781576070086],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        8657485279984132429,
        1522560610487272371,
        3174553425115479790
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    MyQrCode: EntityDefinition<MyQrCode>(
        model: _entities[0],
        toOneRelations: (MyQrCode object) => [],
        toManyRelations: (MyQrCode object) => {},
        getId: (MyQrCode object) => object.id,
        setId: (MyQrCode object, int id) {
          object.id = id;
        },
        objectToFB: (MyQrCode object, fb.Builder fbb) {
          final contentOffset =
              object.content == null ? null : fbb.writeString(object.content!);
          final typeOffset =
              object.type == null ? null : fbb.writeString(object.type!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, contentOffset);
          fbb.addOffset(2, typeOffset);
          fbb.addBool(3, object.pcr);
          fbb.addInt64(4, object.date.millisecondsSinceEpoch);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = MyQrCode(
              content: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              pcr: const fb.BoolReader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              date: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0)),
              type: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [MyQrCode] entity fields to define ObjectBox queries.
class MyQrCode_ {
  /// see [MyQrCode.id]
  static final id = QueryIntegerProperty<MyQrCode>(_entities[0].properties[0]);

  /// see [MyQrCode.content]
  static final content =
      QueryStringProperty<MyQrCode>(_entities[0].properties[1]);

  /// see [MyQrCode.type]
  static final type = QueryStringProperty<MyQrCode>(_entities[0].properties[2]);

  /// see [MyQrCode.pcr]
  static final pcr = QueryBooleanProperty<MyQrCode>(_entities[0].properties[3]);

  /// see [MyQrCode.date]
  static final date =
      QueryIntegerProperty<MyQrCode>(_entities[0].properties[4]);
}
