import 'package:flutter/material.dart';


class Perceptron extends StatefulWidget {
  @override
  _PerceptronState createState() => _PerceptronState();
}

class _PerceptronState extends State<Perceptron> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perceptron"),
        backgroundColor: Colors.redAccent[400],
      ),
     body: new Container(
          padding: const EdgeInsets.all(20.0),
          child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           new PerceptronWidget()
        ],
      )),
    );
  }
}


class PerceptronWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PerceptronWidgetState();
}

class PerceptronWidgetState extends State<PerceptronWidget> {
  final _formKey = GlobalKey<FormState>();
  dynamic start = perceptron([[0, 6], [1, 5], [3, 3], [2, 4]], 4);
  int maxItr;
  double maxTime;
  double sigma;
  dynamic result;
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
              child: Text(result == null ? '' : 'W1 = ${result[0]}\n'
                  'W2 = ${result[1]}\n'
                  '           Iterations = ${result[2]}\n'
                  '            Time = ${result[3]}s', style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
              ),
              Row(
                children: [
                  Container(padding:EdgeInsets.all(15.0),
                      child: Text('How much iterations:', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),)),
                  Expanded(
                      child:
                      Container(padding:EdgeInsets.all(15.0),
                          child:
                          TextFormField(
                            validator: (value) {
                              if(value == null){
                                return null;
                              }
                              maxItr = num.tryParse(value);
                              if(maxItr == null){
                                return '"$value" is not a valid number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          )
                      )
                  ),
                ],
              ),
              Row(
                children: [
                  Container(padding:EdgeInsets.all(15.0),
                      child: new Text('                    Max time:', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),)),
                  Expanded(
                      child:
                      Container(padding:EdgeInsets.all(15.0),
                          child:
                          TextFormField(
                            validator: (value) {
                              if(value == null){
                                return null;
                              }
                              maxTime = num.tryParse(value);
                              if(maxTime  == null){
                                return '"$value" is not a valid number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          )
                      )
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                      padding:EdgeInsets.all(8.0),
                      child: new Text('         Education speed:', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),)),
                  Expanded(
                      child:
                      Container(
                          padding:EdgeInsets.all(15.0),
                          child:
                          TextFormField(
                            validator: (value) {
                              if(value == null){
                                return null;
                              }
                              sigma = num.tryParse(value);
                              if(sigma == null){
                                return '"$value" is not a valid number';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                          )
                      )
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.all(15.0),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      setState(() {
                        result = start(maxItr, maxTime, sigma);
                      });
                    }},
                  child: Text('Confirm'),
                  color: Colors.redAccent[400], textColor: Colors.black,
                ),
              ),
            ]
        )
    );
  }
} 

dynamic perceptron(List<List<int>> points, int p) => (int maxItr, double maxTime, double sigma){
  double w1 = 0;
  double w2 = 0;
  double time = 0;
  int itr = 0;
  var timer = Stopwatch();
  timer..start();
  while(maxItr > itr && maxTime > time){
    for(var point in points){
      var y =  w1 * point[0] + w2 * point[1];
      var delta = p - y;
      var getDelta = delta  > 0 ? delta : 0;
      w1 = w1 + point[0] * getDelta * sigma;
      w2 = w2 + point[1] * getDelta * sigma;
    }
    print("$itr Iterations == << w1 = $w1, w2 = $w2 >>");
    time = (timer.elapsedMilliseconds)/1000;
    itr++;
  }
  return [w1, w2, itr, time];
}; 