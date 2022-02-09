import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'gifticanos_record.g.dart';

abstract class GifticanosRecord
    implements Built<GifticanosRecord, GifticanosRecordBuilder> {
  static Serializer<GifticanosRecord> get serializer =>
      _$gifticanosRecordSerializer;

  @nullable
  String get barcodeImageUrl;

  @nullable
  bool get used;

  @nullable
  String get userId;

  @nullable
  DateTime get validDate;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GifticanosRecordBuilder builder) => builder
    ..barcodeImageUrl = ''
    ..used = false
    ..userId = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Gifticanos');

  static Stream<GifticanosRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<GifticanosRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  GifticanosRecord._();
  factory GifticanosRecord([void Function(GifticanosRecordBuilder) updates]) =
      _$GifticanosRecord;

  static GifticanosRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createGifticanosRecordData({
  String barcodeImageUrl,
  bool used,
  String userId,
  DateTime validDate,
}) =>
    serializers.toFirestore(
        GifticanosRecord.serializer,
        GifticanosRecord((g) => g
          ..barcodeImageUrl = barcodeImageUrl
          ..used = used
          ..userId = userId
          ..validDate = validDate));
