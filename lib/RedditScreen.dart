import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'User.dart';
import 'UserUtil.dart';

class RedditScreen extends StatefulWidget {
  Function currentUri;
  List<User>? userList = null;
  String? previousId;
  String currentPageUrl;
  RedditScreen(this.currentUri, this.currentPageUrl, {Key? key}) : super(key: key);

  @override
  State<RedditScreen> createState() => _RedditScreenState();
}

class _RedditScreenState extends State<RedditScreen> with
    AutomaticKeepAliveClientMixin<RedditScreen>{
  late InAppWebViewController _webViewController;


  @override
  void didUpdateWidget(RedditScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentPageUrl != widget.currentPageUrl) {
      _webViewController.loadUrl(urlRequest: URLRequest(url: Uri.parse(widget.currentPageUrl)));
      _webViewController.setOptions(options: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
          ),
          android: AndroidInAppWebViewOptions(
            useShouldInterceptRequest: true,
          )
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return  GestureDetector(
        child:Container(
          child: InAppWebView(
            gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
            initialUrlRequest: URLRequest(url: Uri.parse(widget.currentPageUrl)),
            onWebViewCreated:(InAppWebViewController controller){
              _webViewController = controller;
              _webViewController.loadUrl(urlRequest: URLRequest(url: Uri.parse(widget.currentPageUrl)));
              _webViewController.setOptions(options: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                  ),
                  android: AndroidInAppWebViewOptions(
                    useShouldInterceptRequest: true,
                  )
              ));

            },

            onLoadStart: (controller, uri) async {

            },
            onUpdateVisitedHistory: (controller, uri, state) async {

              widget.userList ??= await UserUtil.instance.getUserList();
              String? currentId = uri?.path.replaceAll("/", "");
              User? currentUser;
              if(widget.previousId != currentId) {
                if (currentId != null && currentId.isNotEmpty) {
                  currentUser = widget.userList!.firstWhere(
                          (user) => user.facebookId == currentId);
                  if (currentUser != null) {
                    widget.currentUri(uri, currentUser);
                  }
                } else {
                  // current id is null so see what to do
                  widget.currentUri(uri, currentUser);
                }
                //set current user for
                widget.previousId = currentId;
              }else{
                widget.previousId ??=  currentId;
              }
            },

          ),
        )
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>true;
}


