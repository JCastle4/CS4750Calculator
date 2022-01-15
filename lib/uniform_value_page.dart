import 'dart:math';
import 'package:economics_calulator_cs4750/depreciation_page.dart';
import 'package:economics_calulator_cs4750/future_value_page.dart';
import 'package:economics_calulator_cs4750/main.dart';
import 'package:economics_calulator_cs4750/present_value_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UniformValue extends StatefulWidget {
  const UniformValue({Key? key}) : super(key: key);

  @override
  _UniformValueState createState() => _UniformValueState();
}

class _UniformValueState extends State<UniformValue> {

  final _formKey = GlobalKey<FormState>();

  final presentController = TextEditingController();
  final futureController = TextEditingController();
  final rateController = TextEditingController();
  final periodsController = TextEditingController();

  @override
  void dispose(){
    presentController.dispose();
    futureController.dispose();
    rateController.dispose();
    periodsController.dispose();
    super.dispose();
  }

  double outPut =0;
  double present  = 0;
  double future = 0;
  double rate = 0;
  int periods = 0;

  //storing TextFormField values
  void updateText(){
    setState(() {
      if(presentController.text.isEmpty){present=0;}
      else{present = double.parse(presentController.text);}
      if(futureController.text.isEmpty){future=0;}
      else{future = double.parse(futureController.text);}
      rate = double.parse(rateController.text)/100;
      periods = int.parse(periodsController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Uniform Value - A',
            style: TextStyle(fontSize: 30, color: Color(0xFF4C3C54),
            ),
          ),
          backgroundColor: Color(0xFFF8DE90),
          leading: BackButton(color: Color(0xFF4C3C54)),
          actions: [
            IconButton(
              icon: Icon(Icons.home, color: Color(0xFF4C3C54)),
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
                //getting present value
                Row(
                    children: [
                      Expanded(
                          flex: 35,
                          child: Container(
                              margin: EdgeInsets.only(left: 20, right: 5),
                              child: Text(
                                'Present Value',
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
                              controller: presentController,
                              //new InputDecoration ?
                              decoration: InputDecoration(labelText: "pv"),
                              keyboardType: TextInputType.numberWithOptions(),
                              inputFormatters: <TextInputFormatter>[
                                //regex allows for negatives and decimals
                                FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
                              ],
                            ),
                          )
                      )
                    ]
                ),
                //getting future value
                Row(
                    children: [
                      Expanded(
                          flex: 35,
                          child: Container(
                              margin: EdgeInsets.only(left: 20, right: 5),
                              child: Text(
                                'Future value',
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
                              keyboardType: TextInputType.numberWithOptions(),
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
                              keyboardType: TextInputType.numberWithOptions(),
                              inputFormatters: <TextInputFormatter>[
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
                      flex: 35,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 5, top: 30),
                        child: ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFF8DE90))),
                            onPressed: (){
                              //formula for getting uniform value given a present value + uniform given future value
                              if(_formKey.currentState!.validate()) {
                                updateText();
                                double P = present * ((rate * (pow(1 + rate, periods)))
                                    /((pow(1 + rate, periods) - 1)));
                                double F = future *
                                    (rate / (pow(1 + rate, periods) - 1));
                                outPut = P + F;
                              }
                            },
                            child: Text(
                              "ENTER",
                                style: TextStyle(color: Color(0xFF4C3C54),)
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
        ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFFF8DE90),
        ),
        //buttons link to the other pages
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFFD1667B))),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PresentValue()));
                },
                child: Text('P',
                    style: TextStyle(color: Color(0xFF4C3C54),)
                )
            ),
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
