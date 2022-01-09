import 'dart:math';
import 'package:economics_calulator_cs4750/future_value_page.dart';
import 'package:economics_calulator_cs4750/main.dart';
import 'package:economics_calulator_cs4750/present_value_page.dart';
import 'package:economics_calulator_cs4750/uniform_value_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DepreciationValue extends StatefulWidget {
  const DepreciationValue({Key? key}) : super(key: key);

  @override
  _DepreciationValueState createState() => _DepreciationValueState();
}

class _DepreciationValueState extends State<DepreciationValue> {

  final _formKey = GlobalKey<FormState>();

  final basisController = TextEditingController();
  final salvageController = TextEditingController();
  final lifeController = TextEditingController();
  final periodsController = TextEditingController();

  String dropdownvalue = 'Straight Line Method';
  var items =  ['Straight Line Method','Sum-of-Years-Digits Method',
    'Double Decline Balance Method'];

  @override
  void dispose(){
    basisController.dispose();
    salvageController.dispose();
    lifeController.dispose();
    periodsController.dispose();
    super.dispose();
  }

  double outPut =0;
  double basis  = 0;
  double salvage = 0;
  double life = 0;
  int periods = 0;

  void updateText(){
    setState(() {

      if(basisController.text.isEmpty){basis=0;}
      else{basis = double.parse(basisController.text);}
      if(salvageController.text.isEmpty){salvage=0;}
      else{salvage = double.parse(salvageController.text);}
      life = double.parse(lifeController.text);
      periods = int.parse(periodsController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Depreciation',
            style: TextStyle(fontSize: 30),
          ),
          backgroundColor: Color(0xFF789E77),
          //automaticallyImplyLeading: false,
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
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 40, right: 40, top: 30),
                  child: DropdownButton(
                    value: dropdownvalue,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items:items.map((String items) {
                      return DropdownMenuItem(
                          value: items,
                          child: Text(items)
                      );
                    }
                    ).toList(),
                    onChanged: (String? newValue){
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ),

                Row(
                    children: [
                      Expanded(
                          flex: 35,
                          child: Container(
                              margin: EdgeInsets.only(left: 20, right: 5),
                              child: Text(
                                'Cost Basis',
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
                                if(value!.isNotEmpty){
                                  return null;
                                }
                                else return 'required';
                              },
                              textAlign: TextAlign.right,
                              controller: basisController,
                              //new InputDecoration ?
                              decoration: InputDecoration(labelText: "cost"),
                              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                              inputFormatters: [
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
                                'Salvage value',
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
                              controller: salvageController,
                              decoration: InputDecoration(labelText: "salvage"),
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)'))
                                //FilteringTextInputFormatter.digitsOnly
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
                                'Depreciation Life',
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
                              controller: lifeController,
                              decoration: InputDecoration(labelText: "life"),
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
                                'Period',
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
                              decoration: InputDecoration(labelText: "period"),
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
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xFF789E77))),
                            onPressed: (){
                              if(_formKey.currentState!.validate()) {
                                updateText();
                                if(dropdownvalue == 'Straight Line Method'){
                                  outPut = ((basis-salvage)/life);
                                }
                                else if( dropdownvalue =='Sum-of-Years-Digits Method'){
                                  int i = 0;
                                  int sum = 0;
                                  while(i < life){
                                    i+=1;
                                    sum += i;
                                  }
                                  outPut = (life - periods + 1) * (basis - salvage)/ sum;
                                }
                                else if(dropdownvalue == 'Double Decline Balance Method'){
                                  double dt = 0;
                                  double bookValue = basis;

                                  for(int i = 1; i <= periods; i++){
                                    dt = (2/life)*(bookValue);
                                    if(bookValue - dt < 0){ dt = 0;}
                                    else if(bookValue - dt < salvage){ dt = bookValue - salvage;}
                                    bookValue -=dt;
                                  }
                                  outPut = dt;
                                }
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
        ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xFF789E77),
        ),
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
          ],
        ),
      ),
    );
  }
}
