import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'sosv2_model.dart';
export 'sosv2_model.dart';

class Sosv2Widget extends StatefulWidget {
  const Sosv2Widget({super.key});

  static String routeName = 'SOSV2';
  static String routePath = '/sosv2';

  @override
  State<Sosv2Widget> createState() => _Sosv2WidgetState();
}

class _Sosv2WidgetState extends State<Sosv2Widget>
    with TickerProviderStateMixin {
  late Sosv2Model _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Sosv2Model());

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        loop: true,
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          TintEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            color: Colors.black,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'transformOnPageLoadAnimation': AnimationInfo(
        loop: true,
        reverse: true,
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          TintEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            color: Color(0xFFFFFF00),
            begin: 1.0,
            end: 0.0,
          ),
        ],
      ),
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF5F3F1),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: custom_widgets.SOSAnimatedWidget(
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 47.0, 0.0),
                                child: Container(
                                  width: 81.0,
                                  height: 81.0,
                                  child: custom_widgets.TorchToggleButton(
                                    width: 81.0,
                                    height: 81.0,
                                    torchIcon: Icon(
                                      FFIcons.ktorch,
                                      color: Color(0xFF313A51),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 0.0, 0.0),
                              child: Container(
                                width: 81.0,
                                height: 81.0,
                                child: custom_widgets.AudioToggleButton(
                                  width: 81.0,
                                  height: 81.0,
                                  torchIcon: Icon(
                                    FFIcons.ksound,
                                    color: Color(0xFF313A51),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  50.0, 0.0, 0.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (FFAppState().isModeChanged) {
                                    FFAppState().isModeChanged = false;
                                    safeSetState(() {});
                                  } else {
                                    FFAppState().isModeChanged = true;
                                    safeSetState(() {});
                                  }
                                },
                                child: Container(
                                  width: 81.0,
                                  height: 81.0,
                                  child: custom_widgets.ModeButton(
                                    width: 81.0,
                                    height: 81.0,
                                    icon: Icon(
                                      Icons.light_mode,
                                      color: Color(0xFF313A51),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            valueOrDefault<double>(
                              MediaQuery.sizeOf(context).width * 0.05,
                              0.0,
                            ),
                            0.0,
                            valueOrDefault<double>(
                              MediaQuery.sizeOf(context).width * 0.05,
                              0.0,
                            ),
                            15.0),
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          decoration: BoxDecoration(
                            color: Color(0x00F5F5FA),
                            borderRadius:
                                BorderRadius.circular(valueOrDefault<double>(
                              MediaQuery.sizeOf(context).height * 0.025,
                              0.0,
                            )),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(HomeV2Widget.routeName);
                                },
                                child: Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.08,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.home_outlined,
                                        color: Color(0xFF313A51),
                                        size:
                                            MediaQuery.sizeOf(context).height *
                                                0.03,
                                      ),
                                      Text(
                                        'Home',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF313A51),
                                              fontSize:
                                                  MediaQuery.sizeOf(context)
                                                          .height *
                                                      0.015,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(ContactsV2Widget.routeName);
                                },
                                child: Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.08,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.addressBook,
                                        color: Color(0xFF313A51),
                                        size:
                                            MediaQuery.sizeOf(context).height *
                                                0.03,
                                      ),
                                      Text(
                                        'Contacts',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF313A51),
                                              fontSize:
                                                  MediaQuery.sizeOf(context)
                                                          .height *
                                                      0.015,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(Sosv2Widget.routeName);
                                },
                                child: Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.08,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.solidBell,
                                        color: Color(0xFF313A51),
                                        size:
                                            MediaQuery.sizeOf(context).height *
                                                0.03,
                                      ),
                                      Text(
                                        'SOS',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF313A51),
                                              fontSize:
                                                  MediaQuery.sizeOf(context)
                                                          .height *
                                                      0.015,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  context.pushNamed(ProfileV2Widget.routeName);
                                },
                                child: Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.08,
                                  decoration: BoxDecoration(
                                    color: Color(0x00FFFFFF),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person_outline,
                                        color: Color(0xFF313A51),
                                        size:
                                            MediaQuery.sizeOf(context).height *
                                                0.03,
                                      ),
                                      Text(
                                        'Profile',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.inter(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF313A51),
                                              fontSize:
                                                  MediaQuery.sizeOf(context)
                                                          .height *
                                                      0.015,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
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
                    ],
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
