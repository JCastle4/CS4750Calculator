import 'dart:math';
import 'package:economics_calulator_cs4750/depreciation_page.dart';
import 'package:economics_calulator_cs4750/future_value_page.dart';
import 'package:economics_calulator_cs4750/main.dart';
import 'package:economics_calulator_cs4750/uniform_value_page.dart';
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

  //storing TextFormField values
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
            'Present Value - P',
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Color(0xFFD1667B),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage(title: "Engineering Economics Calculator")),
                );
              },
            ),
          ],
        ),

        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20.0),
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //getting future value
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
                              decoration: InputDecoration(labelText: "fv"),
                              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                              inputFormatters: <TextInputFormatter>[
                                //regex allows for negatives and decimals
                                FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
                              ],
                            ),
                          )
                      )
                    ]
                ),
                //getting uniform value
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
                                //regex allows for negatives and decimals
                                FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
                              ],
                            ),
                          )
                      )
                    ]
                ),
                //getting interest rate
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
                                //regex allows for decimals
                                FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
                              ],
                            ),
                          )
                      )
                    ]
                ),
                //getting the period
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
                //enter button and output textField
                Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 5, top: 30),
                        child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFD1667B))),
                            onPressed: (){
                              //formula for getting present value given a future value + present given uniform value
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
        ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFFD1667B),
        ),
        //buttons link to the other pages
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFF8B66D))),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FutureValue()));
                },
                child: Text('F',
                    style: TextStyle(color: Color(0xFF4C3C54),)
                )
            ),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFF8DE90))),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UniformValue()));
                },
                child: Text('A',
                    style: TextStyle(color: Color(0xFF4C3C54),)
                )
            ),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF789E77))),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DepreciationValue()));
                },
                child: Text('dt',
                style: TextStyle(color: Color(0xFF4C3C54),)
                )
            ),
          ],
        ),
      ),
    );
  }
}
