import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PresentValue extends StatefulWidget {
  const PresentValue({Key? key}) : super(key: key);

  @override
  _PresentValueState createState() => _PresentValueState();
}

class _PresentValueState extends State<PresentValue> {
  double outPut =0;

  final futureController = TextEditingController();
  final uniformController = TextEditingController();
  final rateController = TextEditingController();
  final periodsController = TextEditingController();

  @override
  void dispose(){
    futureController.dispose();
    uniformController.dispose();
    rateController.dispose();
    periodsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Present Value',
            style: TextStyle(fontSize: 30),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  children: [
                    Expanded(
                      flex: 35,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                                'Future Value - F',
                              style: TextStyle(
                              fontSize: 15,
                            ),
                            )
                        )
                    ),
                    Expanded(
                        flex: 50,
                        child: Container(
                          margin: EdgeInsets.only(right: 20, left: 5),
                          child: TextField(
                            controller: futureController,
                            //new InputDecoration ?
                            decoration: InputDecoration(labelText: "Enter your number"),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        )
                    )
                  ]
              ),
              Row(
                  children: [
                    Expanded(
                        flex: 35,
                        child: Container(
                            margin: EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                              'Uniform amount - A',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            )
                        )
                    ),
                    Expanded(
                        flex: 50,
                        child: Container(
                          margin: EdgeInsets.only(right: 20, left: 5),
                          child: TextField(
                            controller: uniformController,
                            decoration: InputDecoration(labelText: "Enter your number"),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        )
                    )
                  ]
              ),
              Row(
                  children: [
                    Expanded(
                        flex: 35,
                        child: Container(
                            margin: EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                              'Interest Rate - i',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            )
                        )
                    ),
                    Expanded(
                        flex: 50,
                        child: Container(
                          margin: EdgeInsets.only(right: 20, left: 5),
                          child: TextField(
                            controller: rateController,
                            decoration: InputDecoration(labelText: "Enter your number"),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        )
                    )
                  ]
              ),
              Row(
                  children: [
                    Expanded(
                        flex: 35,
                        child: Container(
                            margin: EdgeInsets.only(left: 20, right: 5),
                            child: Text(
                              'Periods - n',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            )
                        )
                    ),
                    Expanded(
                        flex: 50,
                        child: Container(
                          margin: EdgeInsets.only(right: 20, left: 5),
                          child: TextField(
                            controller: periodsController,
                            decoration: InputDecoration(labelText: "Enter your number"),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        )
                    )
                  ]
              ),
              Row(
                children: [
                  Expanded(
                    flex: 30,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 5, top: 30),
                      child: ElevatedButton(
                          onPressed: (){
                           // double num1 = double.parse(futureController.text())
                            //outPut = futureController

                          },
                          child: Text(
                            "ENTER",
                              )
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 70,
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        margin: EdgeInsets.only(left: 5, right: 20, top: 30),
                        child: Text(
                          '$outPut',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              backgroundColor: Colors.amberAccent,
                            fontSize: 15,
                          ),

                        ),
                      )
                  )

                ],
              ),
            ],
          ),
        ));
  }
}
