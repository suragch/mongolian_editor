import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditorPage extends StatefulWidget {
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final textController = TextEditingController();
  var fontFamily = 'menksoft';
  StreamSubscription? _autoSaveSubscription;
  var _previousText = '';
  static const _autoSaveKey = 'text';

  @override
  void initState() {
    super.initState();
    _getSavedText();
    _autoSaveSubscription =
        Stream.periodic(Duration(minutes: 1)).listen((event) {
      _autoSave();
    });
  }

  void _getSavedText() async {
    final prefs = await SharedPreferences.getInstance();
    final text = prefs.getString(_autoSaveKey);
    if (text == null) return;
    textController.text = text;
    _previousText = text;
  }

  void _autoSave() async {
    final text = textController.text;
    if (text == _previousText) return;
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_autoSaveKey, text);
    _previousText = text;
  }

  @override
  void dispose() {
    _autoSaveSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            'Mongolian Editor',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Expanded(
            child: MongolTextField(
              controller: textController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              maxLines: 1000,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 20,
              ),
              autofocus: true,
            ),
          ),
          SizedBox(height: 20),
          Wrap(
            children: [
              SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(
                    ClipboardData(text: textController.text),
                  );
                },
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    fontFamily = 'menksoft';
                  });
                },
                child: Text('Menksoft font'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    fontFamily = 'delehi';
                  });
                },
                child: Text('Delehi font'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
