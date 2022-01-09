import 'package:economics_calulator_cs4750/depreciation_page.dart';
import 'package:economics_calulator_cs4750/future_value_page.dart';
import 'package:economics_calulator_cs4750/present_value_page.dart';
import 'package:economics_calulator_cs4750/uniform_value_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Engineering Economics Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(widget.title),
          backgroundColor: Color(0xFF4C3C54)
        //automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5, top: 10),
              width: 300,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFD1667B))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PresentValue()));
                  },
                  child: Text(
                    'Present Value',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5, top: 5),
              width: 300,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFF8B66D))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FutureValue()));
                  },
                  child: const Text(
                    'Future Value',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5, top: 5),
              width: 300,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFF8DE90))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UniformValue()));
                  },
                  child: const Text(
                    'Uniform Series',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 10, top: 5),
              width: 300,
              height: 50,
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF789E77))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepreciationValue()));
                  },
                  child: const Text(
                    'Depreciation',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
