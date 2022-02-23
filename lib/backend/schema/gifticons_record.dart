import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'gifticons_record.g.dart';

abstract class GifticonsRecord
    implements Built<GifticonsRecord, GifticonsRecordBuilder> {
  static Serializer<GifticonsRecord> get serializer =>
      _$gifticonsRecordSerializer;

  @nullable
  String get barcodeNumber;

  @nullable
  String get failReason;

  @nullable
  String get imageURL;

  @nullable
  int get price;

  @nullable
  String get status;

  @nullable
  DateTime get uploadedAt;

  @nullable
  DocumentReference get userId;

  @nullable
  @BuiltValueField(wireName: 'selling_status')
  String get sellingStatus;

  @nullable
  @BuiltValueField(wireName: 'resell_price')
  int get resellPrice;

  @nullable
  bool get hasProblem;

  @nullable
  bool get refund;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GifticonsRecordBuilder builder) => builder
    ..barcodeNumber = ''
    ..failReason = ''
    ..imageURL = ''
    ..price = 0
    ..status = ''
    ..sellingStatus = ''
    ..resellPrice = 0
    ..hasProblem = false
    ..refund = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Gifticons');

  static Stream<GifticonsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<GifticonsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  GifticonsRecord._();
  factory GifticonsRecord([void Function(GifticonsRecordBuilder) updates]) =
      _$GifticonsRecord;

  static GifticonsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createGifticonsRecordData({
  String barcodeNumber,
  String failReason,
  String imageURL,
  int price,
  String status,
  DateTime uploadedAt,
  DocumentReference userId,
  String sellingStatus,
  int resellPrice,
  bool hasProblem,
  bool refund,
}) =>
    serializers.toFirestore(
        GifticonsRecord.serializer,
        GifticonsRecord((g) => g
          ..barcodeNumber = barcodeNumber
          ..failReason = failReason
          ..imageURL = imageURL
          ..price = price
          ..status = status
          ..uploadedAt = uploadedAt
          ..userId = userId
          ..sellingStatus = sellingStatus
          ..resellPrice = resellPrice
          ..hasProblem = hasProblem
          ..refund = refund));
