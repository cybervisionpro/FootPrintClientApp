import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'User.dart';
import 'UserUtil.dart';

class FacebookScreen extends StatefulWidget {
  Function currentUri;
  List<User>? userList = null;
  String? previousId;
  String currentPageUrl;
   FacebookScreen(this.currentUri, this.currentPageUrl, {Key? key}) : super(key: key);

  @override
  State<FacebookScreen> createState() => _FacebookScreenState();
}

class _FacebookScreenState extends State<FacebookScreen> with
AutomaticKeepAliveClientMixin<FacebookScreen>{
 late InAppWebViewController _webViewController;


 @override
 void didUpdateWidget(FacebookScreen oldWidget) {
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
     print("FacebookScreen didUpdateWidget :   :didUpdateWidget Method Called  ||||||||||||||||||    |||||||||||||||||||| called } ");
   }
 }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print("FacebookScreen Build Method Called  ||||||||||||||||||    |||||||||||||||||||| called } ");
    print("FacebookScreen Build Method Called  |||||||||||||||||| Opening ${widget.currentPageUrl}    |||||||||||||||||||| called } ");

    return  GestureDetector(
        child:Container(
          child: InAppWebView(
            gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
            initialUrlRequest: URLRequest(url: Uri.parse(widget.currentPageUrl)),
            onWebViewCreated:(InAppWebViewController controller){
              _webViewController = controller;
              _webViewController.loadUrl(urlRequest: URLRequest(url: Uri.parse(widget.currentPageUrl)));
              print("FacebookScreen Build Method Called  |||||||||||||||||| Requesting ${widget.currentPageUrl}    |||||||||||||||||||| called }");
              _webViewController.setOptions(options: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useShouldOverrideUrlLoading: true,
                  ),
                  android: AndroidInAppWebViewOptions(
                    useShouldInterceptRequest: true,
                  )
              ));

            },
          /*   shouldOverrideUrlLoading: (controller, navigationAction) async {
          *//*     print("111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
               print("Yes, User has opened url  shouldOverrideUrlLoading called l ${navigationAction.request.url?.path} ");*//*
               widget.currentPageUrl = navigationAction.request.url.toString();
            },*/
            onLoadStart: (controller, uri) async {
         /*     print("222222222222222222222222222222222222222222222222222222222222222222222222222222222222");
              print("Yes, User has opened url  onLoadStart called  ${uri?.path} ");*/
             // widget.currentPageUrl = uri.toString();
            },
           /* onProgressChanged: (controller, progress) async {
              print("_|_|_||_|_|_|__|_|_|_|_|_|_|_|_|_|_|_|__|__|_|_|_|_|_|_|_|_|_|_|_||_|_|_|_|_||__|_|__|___||_|||||_|_|_|__|_||__|__|__|__|_||___|_||_|_|__|_|__|_");
              print("Yes, User has opened url  onProgressChanged called  ${controller.getUrl().toString()} ");
              widget.currentPageUrl = uri.toString();
            },*/
            onUpdateVisitedHistory: (controller, uri, state) async {
              print("333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333");
              print("Yes, User has opened url  onUpdateVisitedHistory called  ${uri?..toString()} ");

              widget.userList ??= await UserUtil.instance.getUserList();
              print("Yes, User has opened url  onUpdateVisitedHistory called: UserList:  ${widget.userList?..toString()} ");
              String? currentId = uri?.path.replaceAll("/", "");
              User? currentUser;
              if(widget.previousId != currentId) {
                if (currentId != null && currentId.isNotEmpty) {
                  currentUser = widget.userList!.firstWhere(
                          (user) => user.facebookId == currentId);
                  if (currentUser != null) {
                    // Is matched so set Current User to main and call setState
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
            //  widget.currentUri(uri);
           //   widget.currentPageUrl = uri.toString();

            },

          ),
        )
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>true;
}


