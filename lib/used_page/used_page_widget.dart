import '../backend/api_requests/api_calls.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../custom_code/actions/index.dart' as actions;
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsedPageWidget extends StatefulWidget {
  const UsedPageWidget({Key key}) : super(key: key);

  @override
  _UsedPageWidgetState createState() => _UsedPageWidgetState();
}

class _UsedPageWidgetState extends State<UsedPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0x00EEEEEE),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '사용 완료건 처리',
                        style: FlutterFlowTheme.of(context).title1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          labelColor: FlutterFlowTheme.of(context).primaryColor,
                          labelStyle: FlutterFlowTheme.of(context).bodyText1,
                          indicatorColor:
                              FlutterFlowTheme.of(context).secondaryColor,
                          tabs: [
                            Tab(
                              text: '2차 경고',
                            ),
                            Tab(
                              text: '3차 경고',
                            ),
                            Tab(
                              text: '전화',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              StreamBuilder<List<GifticonsRecord>>(
                                stream: queryGifticonsRecord(
                                  queryBuilder: (gifticonsRecord) =>
                                      gifticonsRecord
                                          .where('hasProblem', isEqualTo: true)
                                          .where('refund', isNotEqualTo: true),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                  List<GifticonsRecord>
                                      listViewGifticonsRecordList =
                                      snapshot.data;
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        listViewGifticonsRecordList.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewGifticonsRecord =
                                          listViewGifticonsRecordList[
                                              listViewIndex];
                                      return Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: Color(0xFFF5F5F5),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Image.network(
                                                listViewGifticonsRecord
                                                    .imageURL,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                fit: BoxFit.contain,
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'barcode : ${listViewGifticonsRecord.barcodeNumber}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    'waring_count : ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '최근 경고 발송 : ${dateTimeFormat('M/d h:mm a', listViewGifticonsRecord.recentSentAt)}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '업로드 날짜 : ${dateTimeFormat('M/d H:mm', listViewGifticonsRecord.uploadedAt)}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '가격 : ${listViewGifticonsRecord.price.toString()}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '이름 : ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '전화번호 : ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 10, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        final gifticonsUpdateData =
                                                            createGifticonsRecordData(
                                                          refund: true,
                                                        );
                                                        await listViewGifticonsRecord
                                                            .reference
                                                            .update(
                                                                gifticonsUpdateData);
                                                      },
                                                      text: '입금확인',
                                                      options: FFButtonOptions(
                                                        width: 130,
                                                        height: 40,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle2
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius: 12,
                                                      ),
                                                    ),
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        await SendWarningOneCall
                                                            .call(
                                                          gifticonId: functions
                                                              .getGifticonId(
                                                                  listViewGifticonsRecord
                                                                      .reference),
                                                          templateCode:
                                                              'gifticon_alreadyused',
                                                        );
                                                      },
                                                      text: '2차 경고 발송',
                                                      options: FFButtonOptions(
                                                        width: 130,
                                                        height: 40,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle2
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              StreamBuilder<List<GifticonsRecord>>(
                                stream: queryGifticonsRecord(
                                  queryBuilder: (gifticonsRecord) =>
                                      gifticonsRecord
                                          .where('hasProblem', isEqualTo: true)
                                          .where('refund', isNotEqualTo: true),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                  List<GifticonsRecord>
                                      listViewGifticonsRecordList =
                                      snapshot.data;
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        listViewGifticonsRecordList.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewGifticonsRecord =
                                          listViewGifticonsRecordList[
                                              listViewIndex];
                                      return Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: Color(0xFFF5F5F5),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Image.network(
                                                listViewGifticonsRecord
                                                    .imageURL,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                fit: BoxFit.contain,
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'barcode : ${listViewGifticonsRecord.barcodeNumber}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    'waring_count : ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '최근 경고 발송 : ${dateTimeFormat('M/d h:mm a', listViewGifticonsRecord.recentSentAt)}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '업로드 날짜 : ${dateTimeFormat('M/d H:mm', listViewGifticonsRecord.uploadedAt)}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '가격 : ${listViewGifticonsRecord.price.toString()}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '이름 : ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '전화번호 : ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 10, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        final gifticonsUpdateData =
                                                            createGifticonsRecordData(
                                                          refund: true,
                                                        );
                                                        await listViewGifticonsRecord
                                                            .reference
                                                            .update(
                                                                gifticonsUpdateData);
                                                      },
                                                      text: '입금확인',
                                                      options: FFButtonOptions(
                                                        width: 130,
                                                        height: 40,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle2
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius: 12,
                                                      ),
                                                    ),
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        await SendWarningTwoCall
                                                            .call(
                                                          templateCode:
                                                              'gifticon_used_2',
                                                          gifticonId: functions
                                                              .getGifticonId(
                                                                  listViewGifticonsRecord
                                                                      .reference),
                                                        );
                                                      },
                                                      text: '3차 경고 발송',
                                                      options: FFButtonOptions(
                                                        width: 130,
                                                        height: 40,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle2
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              StreamBuilder<List<GifticonsRecord>>(
                                stream: queryGifticonsRecord(
                                  queryBuilder: (gifticonsRecord) =>
                                      gifticonsRecord
                                          .where('hasProblem', isEqualTo: true)
                                          .where('refund', isNotEqualTo: true),
                                ),
                                builder: (context, snapshot) {
                                  // Customize what your widget looks like when it's loading.
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: CircularProgressIndicator(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                  List<GifticonsRecord>
                                      listViewGifticonsRecordList =
                                      snapshot.data;
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        listViewGifticonsRecordList.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final listViewGifticonsRecord =
                                          listViewGifticonsRecordList[
                                              listViewIndex];
                                      return Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: Color(0xFFF5F5F5),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Image.network(
                                                listViewGifticonsRecord
                                                    .imageURL,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.5,
                                                fit: BoxFit.contain,
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'barcode : ${listViewGifticonsRecord.barcodeNumber}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    'waring_count : ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '최근 경고 발송 : ${dateTimeFormat('M/d h:mm a', listViewGifticonsRecord.recentSentAt)}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '업로드 날짜 : ${dateTimeFormat('M/d H:mm', listViewGifticonsRecord.uploadedAt)}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '가격 : ${listViewGifticonsRecord.price.toString()}',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '이름 : ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                  Text(
                                                    '전화번호 : ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1,
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 10, 0, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        final gifticonsUpdateData =
                                                            createGifticonsRecordData(
                                                          refund: true,
                                                        );
                                                        await listViewGifticonsRecord
                                                            .reference
                                                            .update(
                                                                gifticonsUpdateData);
                                                      },
                                                      text: '입금확인',
                                                      options: FFButtonOptions(
                                                        width: 130,
                                                        height: 40,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle2
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius: 12,
                                                      ),
                                                    ),
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        await actions
                                                            .makePhoneCall(
                                                          listViewGifticonsRecord,
                                                        );
                                                      },
                                                      text: '전화 걸기',
                                                      options: FFButtonOptions(
                                                        width: 130,
                                                        height: 40,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryColor,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle2
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1,
                                                        ),
                                                        borderRadius: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
