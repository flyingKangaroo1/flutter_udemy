import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:location_example/change_settings.dart';
import 'package:location_example/enable_in_background.dart';
import 'package:url_launcher/url_launcher.dart';

import 'change_notification.dart';
import 'get_location.dart';
import 'listen_location.dart';
import 'permission_status.dart';
import 'service_enabled.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Location',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Flutter Location Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Location location = Location();

  Future<void> _showInfoDialog() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Demo Application'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text('Created by Guillaume Bernos'),
                InkWell(
                  child: const Text(
                    'https://github.com/Lyokone/flutterlocation',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () =>
                      launch('https://github.com/Lyokone/flutterlocation'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: _showInfoDialog,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: const <Widget>[
              PermissionStatusWidget(),
              Divider(height: 32),
              ServiceEnabledWidget(),
              Divider(height: 32),
              GetLocationWidget(),
              Divider(height: 32),
              ListenLocationWidget(),
              Divider(height: 32),
              ChangeSettings(),
              Divider(height: 32),
              EnableInBackgroundWidget(),
              Divider(height: 32),
              ChangeNotificationWidget()
            ],
          ),
        ),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('URL Launcher'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final url = Uri.parse(
                  'https://dev-yakuza.posstree.com/en/',
                );
                if (await canLaunchUrl(url)) {
                  launchUrl(url);
                } else {
                  // ignore: avoid_print
                  print("Can't launch $url");
                }
              },
              child: const Text('Web Link'),
            ),
            ElevatedButton(
              onPressed: () async {
                final url = Uri(
                  scheme: 'mailto',
                  path: 'dev-yakuza@gmail.com',
                  query: 'subject=Hello&body=Test',
                );
                if (await canLaunchUrl(url)) {
                  launchUrl(url);
                } else {
                  // ignore: avoid_print
                  print("Can't launch $url");
                }
              },
              child: const Text('Mail to'),
            ),
            ElevatedButton(
              onPressed: () async {
                final url = Uri.parse('tel:+1 555 010 999');
                if (await canLaunchUrl(url)) {
                  launchUrl(url);
                } else {
                  // ignore: avoid_print
                  print("Can't launch $url");
                }
              },
              child: const Text('Tel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final url = Uri.parse('sms:5550101234');
                if (await canLaunchUrl(url)) {
                  launchUrl(url);
                } else {
                  // ignore: avoid_print
                  print("Can't launch $url");
                }
              },
              child: const Text('SMS'),
            ),
          ],
        ),
      ),
    );
  }
}
*/
/*
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

void main() => runApp(FilePickerTest());

class FilePickerTest extends StatefulWidget {
  const FilePickerTest({Key? key}) : super(key: key);

  @override
  FilePickerTestState createState() => FilePickerTestState();
}

class FilePickerTestState extends State<FilePickerTest> {

  String showFileName = "";
  Color defaultColor = Colors.grey[400]!;

  Container makeFilePicker(){
    return Container(
      height: 200,
      width: 400,
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: defaultColor,),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['jpg', 'jpeg', 'png'],
              );
              if( result != null && result.files.isNotEmpty ){
                String fileName = result.files.first.name;
                Uint8List fileBytes = result.files.first.bytes!;
                debugPrint(fileName);
                setState(() {
                  showFileName = "Now File Name: $fileName";
                });
                /*
                do jobs
                 */
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Find and Upload", style: TextStyle(fontWeight: FontWeight.bold, color: defaultColor, fontSize: 20,),),
                Icon(Icons.upload_rounded, color: defaultColor,),
              ],
            ),
          ),
          Text("(*.png)", style: TextStyle(color: defaultColor,),),
          const SizedBox(height: 10,),
          Text(showFileName, style: TextStyle(color: defaultColor,),),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Assignment 1'),
        ),
        body: Center(child: makeFilePicker()),
      )
    );
  }
}
*/