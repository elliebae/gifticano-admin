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
  DateTime get recentSentAt;

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

  static GifticonsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      GifticonsRecord(
        (c) => c
          ..barcodeNumber = snapshot.data['barcodeNumber']
          ..failReason = snapshot.data['failReason']
          ..imageURL = snapshot.data['imageURL']
          ..price = snapshot.data['price']
          ..status = snapshot.data['status']
          ..uploadedAt = safeGet(() =>
              DateTime.fromMillisecondsSinceEpoch(snapshot.data['uploadedAt']))
          ..userId = safeGet(() => toRef(snapshot.data['userId']))
          ..sellingStatus = snapshot.data['selling_status']
          ..resellPrice = snapshot.data['resell_price']
          ..hasProblem = snapshot.data['hasProblem']
          ..refund = snapshot.data['refund']
          ..recentSentAt = safeGet(() => DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['recentSentAt']))
          ..reference = GifticonsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<GifticonsRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'Gifticons',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

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
  DateTime recentSentAt,
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
          ..refund = refund
          ..recentSentAt = recentSentAt));
