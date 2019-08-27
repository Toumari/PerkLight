import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class SharePage extends StatelessWidget {
  SharePage(this.encodedData);

  final String encodedData;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xff21213b),
        appBar: AppBar(
          title: Text('Share Build'),
          backgroundColor: Color(0xff21213b),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Share'),
              Tab(text: 'Scan'),
            ],
          ),
        ),
        body:  TabBarView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 10.0
                      ),
                    ),
                    margin: EdgeInsets.only(top: screen.width * 0.2),
                    child: QrImage(
                      backgroundColor: Colors.white,
                      padding: EdgeInsets.all(screen.width * 0.05),
                      data: encodedData,
                      version: QrVersions.auto,
                      size: screen.width * 0.6
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: screen.width * 0.05, left: screen.width * 0.2, right: screen.width * 0.2),
                  child: FlatButton(
                    child: Text('Share this Build', style: TextStyle(fontSize: 20.0, color: Colors.white), textAlign: TextAlign.center),
                    onPressed: () => Share.share('https://perklight.app/build/$encodedData', subject: 'APP URI'),
                  )
                ),
              ]
            ),
            Column(
              children: <Widget>[
                Expanded(
                  child: Text('CAMERA GOES HERE?', style: TextStyle(fontSize: 30.0, color: Colors.white))
                )
              ]
            )
          ],
        )
      )
    );
  }
}