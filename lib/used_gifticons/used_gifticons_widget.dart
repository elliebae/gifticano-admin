import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UsedGifticonsWidget extends StatefulWidget {
  const UsedGifticonsWidget({Key key}) : super(key: key);

  @override
  _UsedGifticonsWidgetState createState() => _UsedGifticonsWidgetState();
}

class _UsedGifticonsWidgetState extends State<UsedGifticonsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).tertiaryColor,
    );
  }
}
