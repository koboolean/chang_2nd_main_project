import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class PlaceInfoMap extends StatefulWidget {
  const PlaceInfoMap(
      {super.key,
      required this.mapAddress,
      required this.mapName,
      required this.mapImage,
      required this.mapLat,
      required this.mapLong});
  final String mapAddress;
  final String mapName;
  final String mapImage;
  final String mapLat;
  final String mapLong;

  @override
  State<PlaceInfoMap> createState() => _PlaceInfoMap();
}

class _PlaceInfoMap extends State<PlaceInfoMap> {
  // WebViewPlusController? _controller;
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  WebViewController? _webViewController;
  void _loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/ref/index.html');
    _webViewController!.loadUrl(Uri.dataFromString(fileText,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }

  @override
  Widget build(BuildContext context) {
    final double contentSize = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        54;
    final pixeRatio =
        MediaQuery.of(context).devicePixelRatio; // 픽셀 전환시 화면의 비율 값 추출

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: ElevatedButton(
        //     child: Text(widget.mapAddress),
        //     onPressed: () {},
        //   ),
        // ),
        //바디 확장
        //extendBody: true,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 54,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.mapName,
                    style: TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                //컨데이터를 expanded()로 맞추고  layoutbliud()로 컨데이터를
                //body(부모) - container(자식) 으로 layoutbliud() 구성해서
                //max가로,세로의 크기를 get하여 webview로 사이즈를 넘겨줌
                Container(
                  height: contentSize,
                  width: double.infinity,
                  child: WebView(
                    initialUrl: 'assets/ref/index.html',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _webViewController = webViewController;
                      _loadHtmlFromAssets();
                    },
                    javascriptChannels: Set.from([
                      JavascriptChannel(
                          name: "JavascriptChannel",
                          onMessageReceived: (JavascriptMessage result) {
                            print('webToAppChange 메시지 : "${result.message}"');
                          }),
                    ]),
                    onPageFinished: (url) => _webViewController!.runJavascript(
                        'appToWeb("${widget.mapLat}","${widget.mapLong}",$contentSize,$pixeRatio)'),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsetsDirectional.all(9),
                    width: 339,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                widget.mapName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(widget.mapAddress),
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              widget.mapImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
