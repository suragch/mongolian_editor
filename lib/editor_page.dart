import 'package:flutter/material.dart';
import 'package:mongol/mongol.dart';
import 'package:flutter/services.dart';

class EditorPage extends StatefulWidget {
  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  final textController = TextEditingController();
  var fontFamily = 'menksoft';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Text(
            'Editor',
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
                onPressed: (){
                  setState(() {
                    fontFamily = 'menksoft';
                  });
                },
                child: Text('Menksoft font'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: (){
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
