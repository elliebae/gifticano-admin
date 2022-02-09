import '../backend/backend.dart';
import '../find_price/find_price_widget.dart';
import '../flutter_flow/flutter_flow_choice_chips.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_expanded_image_view.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class CheckGifticonsWidget extends StatefulWidget {
  const CheckGifticonsWidget({Key key}) : super(key: key);

  @override
  _CheckGifticonsWidgetState createState() => _CheckGifticonsWidgetState();
}

class _CheckGifticonsWidgetState extends State<CheckGifticonsWidget> {
  Map<GifticonsRecord, bool> checkboxListTileValueMap = {};
  List<GifticonsRecord> get checkboxListTileCheckedItems =>
      checkboxListTileValueMap.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .toList();

  String choiceChipsValue;
  TextEditingController textController1;
  TextEditingController textController2;
  String dropDownValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: GestureDetector(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 60,
                      icon: Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FindPriceWidget(),
                          ),
                        );
                      },
                    ),
                    Text(
                      '검수',
                      style: FlutterFlowTheme.title1,
                    ),
                    FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 60,
                      icon: Icon(
                        Icons.refresh_rounded,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        await Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            duration: Duration(milliseconds: 0),
                            reverseDuration: Duration(milliseconds: 0),
                            child: NavBarPage(initialPage: 'CheckGifticons'),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder<List<GifticonsRecord>>(
                  stream: queryGifticonsRecord(
                    queryBuilder: (gifticonsRecord) => gifticonsRecord
                        .where('status', isEqualTo: 'waiting')
                        .orderBy('uploadedAt', descending: true),
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: FlutterFlowTheme.primaryColor,
                          ),
                        ),
                      );
                    }
                    List<GifticonsRecord> listViewGifticonsRecordList =
                        snapshot.data;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: listViewGifticonsRecordList.length,
                      itemBuilder: (context, listViewIndex) {
                        final listViewGifticonsRecord =
                            listViewGifticonsRecordList[listViewIndex];
                        return Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: FlutterFlowExpandedImageView(
                                          image: Image.network(
                                            listViewGifticonsRecord.imageURL,
                                            fit: BoxFit.contain,
                                          ),
                                          allowRotation: false,
                                          tag: listViewGifticonsRecord.imageURL,
                                          useHeroAnimation: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: listViewGifticonsRecord.imageURL,
                                    transitionOnUserGestures: true,
                                    child: Image.network(
                                      listViewGifticonsRecord.imageURL,
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                ),
                                CheckboxListTile(
                                  value: checkboxListTileValueMap[
                                      listViewGifticonsRecord] ??= false,
                                  onChanged: (newValue) => setState(() =>
                                      checkboxListTileValueMap[
                                          listViewGifticonsRecord] = newValue),
                                  title: Text(
                                    '유효기간',
                                    style: FlutterFlowTheme.bodyText1,
                                  ),
                                  tileColor: Colors.white,
                                  dense: false,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                ),
                                FlutterFlowChoiceChips(
                                  initialOption: choiceChipsValue ??= 'waiting',
                                  options: [
                                    ChipData('pass',
                                        Icons.check_circle_outline_rounded),
                                    ChipData('fail', Icons.cancel_outlined)
                                  ],
                                  onChanged: (val) =>
                                      setState(() => choiceChipsValue = val),
                                  selectedChipStyle: ChipStyle(
                                    backgroundColor:
                                        FlutterFlowTheme.primaryColor,
                                    textStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                    iconColor: Colors.white,
                                    iconSize: 18,
                                    elevation: 0,
                                  ),
                                  unselectedChipStyle: ChipStyle(
                                    backgroundColor: Color(0xFFDCDCDC),
                                    textStyle:
                                        FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF262D34),
                                    ),
                                    iconColor: Color(0xFF262D34),
                                    iconSize: 18,
                                    elevation: 0,
                                  ),
                                  chipSpacing: 20,
                                ),
                                if ((choiceChipsValue) == 'pass')
                                  TextFormField(
                                    onChanged: (_) => EasyDebounce.debounce(
                                      'textController1',
                                      Duration(milliseconds: 2000),
                                      () => setState(() {}),
                                    ),
                                    controller: textController1,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: '바코드',
                                      hintText: '바코드',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      suffixIcon: textController1
                                              .text.isNotEmpty
                                          ? InkWell(
                                              onTap: () => setState(
                                                () => textController1.clear(),
                                              ),
                                              child: Icon(
                                                Icons.clear,
                                                color: Color(0xFF757575),
                                                size: 22,
                                              ),
                                            )
                                          : null,
                                    ),
                                    style: FlutterFlowTheme.bodyText1,
                                    keyboardType: TextInputType.number,
                                  ),
                                if ((choiceChipsValue) == 'pass')
                                  TextFormField(
                                    onChanged: (_) => EasyDebounce.debounce(
                                      'textController2',
                                      Duration(milliseconds: 2000),
                                      () => setState(() {}),
                                    ),
                                    controller: textController2,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: '가격',
                                      hintText: '가격',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      suffixIcon: textController2
                                              .text.isNotEmpty
                                          ? InkWell(
                                              onTap: () => setState(
                                                () => textController2.clear(),
                                              ),
                                              child: Icon(
                                                Icons.clear,
                                                color: Color(0xFF757575),
                                                size: 22,
                                              ),
                                            )
                                          : null,
                                    ),
                                    style: FlutterFlowTheme.bodyText1,
                                    keyboardType: TextInputType.number,
                                  ),
                                if ((choiceChipsValue) == 'fail')
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '반려 사유',
                                        style: FlutterFlowTheme.bodyText1,
                                      ),
                                      FlutterFlowDropDown(
                                        options: [
                                          '이미 등록된 기프티콘',
                                          '유효기간이 인식되지 않습니다',
                                          '유효기간이 짧습니다',
                                          '이미지의 해상도가 너무 낮습니다',
                                          '사용 가능한 매장이 정해진 쿠폰',
                                          '사용 시 본인인증이 필요한 쿠폰',
                                          '배송 상품은 등록하실 수 없습니다',
                                          '인식되지 않는 기프티콘',
                                          '기타',
                                          ''
                                        ].toList(),
                                        onChanged: (val) =>
                                            setState(() => dropDownValue = val),
                                        width: 180,
                                        height: 50,
                                        textStyle:
                                            FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                        ),
                                        hintText: 'Please select...',
                                        fillColor: Colors.white,
                                        elevation: 2,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0,
                                        borderRadius: 0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            12, 4, 12, 4),
                                        hidesUnderline: true,
                                      ),
                                    ],
                                  ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      if (checkboxListTileValueMap[
                                          listViewGifticonsRecord]) {
                                        await showDialog(
                                          context: context,
                                          builder: (alertDialogContext) {
                                            return AlertDialog(
                                              title: Text('검수 ㄹㅇ?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          alertDialogContext),
                                                  child: Text('ㄴㄴ'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    Navigator.pop(
                                                        alertDialogContext);

                                                    final gifticonsUpdateData =
                                                        createGifticonsRecordData(
                                                      barcodeNumber:
                                                          textController1.text,
                                                      failReason: dropDownValue,
                                                      price: int.parse(
                                                          textController2.text),
                                                    );
                                                    await listViewGifticonsRecord
                                                        .reference
                                                        .update(
                                                            gifticonsUpdateData);
                                                    ;
                                                  },
                                                  child: Text('ㅇㅇ'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
                                      final gifticonsUpdateData =
                                          createGifticonsRecordData(
                                        status: choiceChipsValue,
                                      );
                                      await listViewGifticonsRecord.reference
                                          .update(gifticonsUpdateData);
                                    },
                                    text: '검수하기',
                                    options: FFButtonOptions(
                                      width: 130,
                                      height: 40,
                                      color: FlutterFlowTheme.primaryColor,
                                      textStyle:
                                          FlutterFlowTheme.subtitle2.override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: 12,
                                    ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
