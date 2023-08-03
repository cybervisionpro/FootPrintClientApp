import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SnapchatScreen extends StatefulWidget {
  const SnapchatScreen({Key? key}) : super(key: key);

  @override
  State<SnapchatScreen> createState() => _SnapchatScreenState();
}

class _SnapchatScreenState extends State<SnapchatScreen> with
    AutomaticKeepAliveClientMixin<SnapchatScreen>{

  var controllerSnapchat = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse('https://accounts.snapchat.com/accounts/login?continue=%2Faccounts%2Fwelcome'));
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: WebViewWidget(
        controller: controllerSnapchat,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
