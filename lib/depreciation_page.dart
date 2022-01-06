import 'dart:math';
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
  double basis  = 100;
  double salvage = 10;
  double life = 10;
  int periods = 0;

  void updateText(){
    setState(() {

      if(basisController.text.isEmpty){basis=0;}
      else{basis = double.parse(basisController.text);}
      if(salvageController.text.isEmpty){salvage=0;}
      else{salvage = double.parse(salvageController.text);}
      life = double.parse(lifeController.text)/100;
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
                                if(value!.isNotEmpty && double.parse(value) > 0){
                                  return null;
                                }
                                else return 'required';
                              },
                              textAlign: TextAlign.right,
                              controller: basisController,
                              //new InputDecoration ?
                              decoration: InputDecoration(labelText: "B"),
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
                              decoration: InputDecoration(labelText: "S"),
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
                                'Life',
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
                              decoration: InputDecoration(labelText: "rate"),
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
                            onPressed: (){
                              if(_formKey.currentState!.validate()) {
                                if(dropdownvalue == 'Straight Line Method'){
                                  outPut = ((basis-salvage)/life);
                                }
                                else if( dropdownvalue =='Sum-of-Years-Digits Method'){
                                  outPut = (0);
                                }
                                else if(dropdownvalue == 'Double Decline Balance Method'){
                                  outPut = 0;
                                }
                                outPut = ((basis-salvage)/life);
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