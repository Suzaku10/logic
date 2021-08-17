import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:collection/collection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Logic And Struktur data'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  List<int> _defaultArray = [6, 8, 1, 4, 7, 2];
  List<int> _array = [];
  String _maxNumber = "";
  String _sumNumber = "";
  String _sortArray = "";
  String _thirdMaxNumber = "";

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1. Fill Textfield if you want to use custom int array"),
                Text(
                    "2. Press button use default array to calculate with default array"),
                Text(
                    "3. Press button use custom array to calculate with custom array"),
                Text("4. If custom array is empty, default array is use"),
                Text("5. default array is : $_defaultArray"),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(16),
              ),
              child: TextField(
                controller: _controller,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('[.-]')),
                  FilteringTextInputFormatter.deny(" "),
                ],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Input int value separated by comma"),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _normalizeArray();
                      calculate(_array);
                    },
                    child: Text("custom array"),
                  ),
                ),
                Container(
                  width: 16,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      calculate(_defaultArray);
                    },
                    child: Text("default array"),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  Text("Sum Array : $_sumNumber"),
                  Text("Sort Array : $_sortArray"),
                  Text("Max number in array : $_maxNumber"),
                  Text("3rd Max number in array : $_thirdMaxNumber"),
                ],
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void calculate(List<int> x) {
    if (x.length == 0) x = _defaultArray;

    setState(() {
      _maxNumber = _getMaxNumber(x);
      _sumNumber = _sumArray(x);
      _sortArray = _sortArrays(x);
      _thirdMaxNumber = _printThirdMaxNumber(x);
    });
  }

  String _printThirdMaxNumber(List<int> x) {
    if (x.length < 2) {
      return "Array must more than 2 index";
    }

    x..sort((a, b) => b.compareTo(a));
    return "${x[2]}";
  }

  String _getMaxNumber(List<int> x) {
    if (x.length < 1) {
      return "Array at least must have 1 index";
    }

    return "${x.reduce(max)}";
  }

  String _sumArray(List<int> x) {
    return "${x.sum}";
  }

  String _sortArrays(List<int> x) {
    return "${x..sort()}";
  }

  void _normalizeArray() {
    String _text = _controller.text;
    if (_text.length == 0) return;
    if (_text.startsWith(",")) _text = _text.substring(1);
    if (_text.endsWith(",")) _text = _text.substring(0, _text.length - 1);

    var _split = _text.split(",");
    _array = _split.map((e) => int.parse(e)).toList();
  }
}
