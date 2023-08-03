import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_social_media_app/UserUtil.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'User.dart';

class InstagramScreen extends StatefulWidget {
  Function currentUri;

  String currentPageUrl;


  InstagramScreen(this.currentUri,  this.currentPageUrl, {Key? key}) : super(key: key);
 List<User>? userList = null;
  String? previousId;
  @override
  State<InstagramScreen> createState() => _InstagramScreenState();
}

class _InstagramScreenState extends State<InstagramScreen> with
AutomaticKeepAliveClientMixin<InstagramScreen>{
  late InAppWebViewController _webViewController;

  @override
  void didUpdateWidget(InstagramScreen oldWidget) {
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
    print("InstagramScreen Build Method Called  ||||||||||||||||||      |||||||||||||||||||| called } ");
    print("InstagramScreen Build Method Called  |||||||||||||||||| Opening ${widget.currentPageUrl}    |||||||||||||||||||| called } ");

    return  GestureDetector(
        child:Container(
          child: InAppWebView(
            gestureRecognizers: Set()..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
            initialUrlRequest: URLRequest(url: Uri.parse(widget.currentPageUrl)),

            onWebViewCreated:(InAppWebViewController controller){
              _webViewController = controller;
              _webViewController.loadUrl(urlRequest: URLRequest(url: Uri.parse(widget.currentPageUrl)));
              print("InstagramScreen Build Method Called  |||||||||||||||||| Requesting ${widget.currentPageUrl}    |||||||||||||||||||| called }");

              _webViewController.setOptions(options: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  useShouldOverrideUrlLoading: true,
                ),
                android: AndroidInAppWebViewOptions(
                  useShouldInterceptRequest: true,
                )
              ));

            },
          /*  shouldOverrideUrlLoading: (controller, navigationAction) async {
         *//*     print("111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
              print("Yes, User has opened url  shouldOverrideUrlLoading called l ${navigationAction.request.url?.path} ");*//*
              widget.currentPageUrl = navigationAction.request.url.toString();
            },*/
            onLoadStart: (controller, uri) async {
            /*  print("222222222222222222222222222222222222222222222222222222222222222222222222222222222222");
              print("Yes, User has opened url  onLoadStart called  ${uri?.path} ");*/
             // widget.currentPageUrl = uri.toString();
            },
           /* onProgressChanged: (controller, progress) async {
              print("_|_|_||_|_|_|__|_|_|_|_|_|_|_|_|_|_|_|__|__|_|_|_|_|_|_|_|_|_|_|_||_|_|_|_|_||__|_|__|___||_|||||_|_|_|__|_||__|__|__|__|_||___|_||_|_|__|_|__|_");
              print("Yes, User has opened url  onProgressChanged called  ${controller.getUrl().toString()} ");

            },*/
            onUpdateVisitedHistory: (controller, uri, state) async {
              print("333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333");
              print("Yes, User has opened url  onUpdateVisitedHistory called  ${uri?..toString()} ");

              widget.userList ??= await UserUtil.instance.getUserList();
              print("Yes, User has opened url  onUpdateVisitedHistory called: UserList:  ${widget.userList?..toString()} ");
              String? currentId = uri?.path.replaceAll("/", "");
              print("Yes, User has opened url  onUpdateVisitedHistory called: currentId:  ${currentId?..toString()} ");

              User? currentUser;

              print("Yes, User has opened url  onUpdateVisitedHistory called:PREVIOUS ID ${widget.previousId} ");
              if(widget.previousId != currentId) {
                print("Yes, User has opened url  onUpdateVisitedHistory called:inside outer if first ${widget.previousId} ");
                if (currentId != null && currentId.isNotEmpty) {
                  currentUser = widget.userList!.firstWhere(
                          (user) => user.instagramId == currentId);

                  if (currentUser != null) {
                    // Is matched so set Current User to main and call setState
                    print("Yes, User has opened url  onUpdateVisitedHistory called: INNER IF ONE MORE: CALLED CURRENT URI FOR SET STATE WITH CURRENT USER ");
                    widget.currentUri(uri, currentUser);

                  }
                  print("Yes, User has opened url  onUpdateVisitedHistory called: INNER IF ");

                } else {
                  // current id is null so see what to do
                  print("Yes, User has opened url  onUpdateVisitedHistory called: INNER ELSE CURRENT ID IS NULL : SETTING CURRENT URI FOR NULL USER");

                  widget.currentUri(uri, currentUser);
                }
                //set current user for
                widget.previousId = currentId;
                print("Yes, User has opened url  onUpdateVisitedHistory called: OUTER IF SETTING PREVIOUS ID ");
              }else{
                widget.previousId ??=  currentId;
              }


            //  widget.currentPageUrl = uri.toString();

            },
          /*  shouldOverrideUrlLoading: (InAppWebViewController inAppWebViewController, NavigationAction action) async {
              print("Yes, User has opened url  shouldOverrideUrlLoading called l");
              String? url = action.request.url?.path;
             if(url != null) {
               print("Yes, User has opened url  shouldOverrideUrlLoading :: $url");
             }

            },*/


          ),
        )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
