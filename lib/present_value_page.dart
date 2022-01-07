import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PresentValue extends StatefulWidget {
  const PresentValue({Key? key}) : super(key: key);

  @override
  _PresentValueState createState() => _PresentValueState();
}

class _PresentValueState extends State<PresentValue> {

  final _formKey = GlobalKey<FormState>();

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

  double outPut =0;
  double future  = 0;
  double uniform = 0;
  double rate = 0;
  int periods = 0;

  void updateText(){
    setState(() {

      if(futureController.text.isEmpty){future=0;}
      else{future = double.parse(futureController.text);}
      if(uniformController.text.isEmpty){uniform=0;}
      else{uniform = double.parse(uniformController.text);}
      rate = double.parse(rateController.text)/100;
      periods = int.parse(periodsController.text);
    });
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
          child: Form(
            key: _formKey,
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
                                  'Future Value',
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
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              controller: futureController,
                              //new InputDecoration ?
                              decoration: InputDecoration(labelText: "fv"),
                              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
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
                                'Uniform amount',
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
                            child: TextFormField(
                              textAlign: TextAlign.right,
                              controller: uniformController,
                              decoration: InputDecoration(labelText: "pmt"),
                              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
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
                                'Interest Rate',
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
                            child: TextFormField(
                              validator: (value){
                                if(value!.isNotEmpty && double.parse(value) > 0){
                                  return null;
                                }
                                else return 'required';
                              },
                              textAlign: TextAlign.right,
                              controller: rateController,
                              decoration: InputDecoration(labelText: "rate"),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
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
                                'Periods',
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
                            child: TextFormField(
                              validator: (value){
                                if(value!.isNotEmpty && double.parse(value) > 0){
                                  return null;
                                }
                                else return 'required';
                              },
                              textAlign: TextAlign.right,
                              controller: periodsController,
                              decoration: InputDecoration(labelText: "nper"),
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
                              if(_formKey.currentState!.validate()) {
                                updateText();
                                double F = future * (pow(1 + (rate), -periods));
                                double A = uniform *
                                    ((pow(1 + rate, periods) - 1) /
                                        (rate * pow(1 + rate, periods)));
                                outPut = F + A;
                              }

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
                            '${outPut.toStringAsFixed(2)}',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                //backgroundColor: Colors.yellowAccent,
                              fontSize: 20,
                            ),

                          ),
                        )
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
