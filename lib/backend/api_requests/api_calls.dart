import '../../flutter_flow/flutter_flow_util.dart';

import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

class SendWarningOneCall {
  static Future<ApiCallResponse> call({
    String templateCode = 'gifticon_alreadyused',
    String gifticonId = '',
  }) {
    final body = '''
{
  "templateCode": "${templateCode}",
  "gifticonId": "${gifticonId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'sendWarningOne',
      apiUrl:
          'https://us-central1-gifticano-74f3e.cloudfunctions.net/gifticano/send',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'templateCode': templateCode,
        'gifticonId': gifticonId,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}

class SendWarningTwoCall {
  static Future<ApiCallResponse> call({
    String templateCode = 'gifticon_used_2',
    String gifticonId = '',
  }) {
    final body = '''
{
  "templateCode": "${templateCode}",
  "gifticonId": "${gifticonId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'sendWarningTwo',
      apiUrl:
          'https://us-central1-gifticano-74f3e.cloudfunctions.net/gifticano/send',
      callType: ApiCallType.POST,
      headers: {},
      params: {
        'templateCode': templateCode,
        'gifticonId': gifticonId,
      },
      body: body,
      bodyType: BodyType.JSON,
      returnBody: true,
    );
  }
}
