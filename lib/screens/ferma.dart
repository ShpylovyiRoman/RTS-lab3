import 'package:flutter/material.dart';
import 'dart:math';

class Ferma extends StatefulWidget {
  @override
  _FermaState createState() => _FermaState();
}

class _FermaState extends State<Ferma> {
  int number;
  dynamic result;
  var time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Algorithm Fermat"),
        backgroundColor: Colors.redAccent[400],
      ),
     body: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new FermatWidget()
        ],
      )),
    );
  }
}
class FermatWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FermatWidgetState();
}
class FermatWidgetState extends State<FermatWidget> {
  final _formKey = GlobalKey<FormState>();
  int number;
  dynamic result;
  Widget build(BuildContext context) {
    return new Form(key: _formKey, child: new Column(
        children: [
          new Row(children: <Widget>[
            new Container(padding:EdgeInsets.all(15.0),child: new Text('Input Number:', style: TextStyle(fontWeight: FontWeight.bold,),)),
            new Expanded(child: Container(padding:EdgeInsets.all(15.0),child:
            // ignore: missing_return
            new TextFormField(validator: (value){
              if (value.isEmpty) return 'Please enter your number';
              try {number = int.parse(value);}
               catch(err) {
                number = null;
                return 'Not a number';
              }
            })
            )),
          ]
          ),
          new SizedBox(height: 15.0),
          // ignore: deprecated_member_use
          new RaisedButton(onPressed: (){
            if(_formKey.currentState.validate()) {
              setState(() {if (number is int) result = fermat(number);});
            }
          }, child: Text('Confirm'), color: Colors.redAccent[400], textColor: Colors.black,),
          new SizedBox(height: 50.0),
          new Text(result == null ? '' : 'p = ${result[0]}\nq = ${result[1]}', style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),)
        ]
    ));
  }
}

List<int> fermat(int n){
  int x = sqrt(n).ceil();
  int y2 = x * x - n;
  int y = sqrt(y2).toInt();
  while(y2 != y * y){
    x++;
    y2 = x * x - n;
    y = sqrt(y2).toInt();
  }
  return [x - y, x + y];
}