import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Genetic extends StatefulWidget {
  @override
  _GeneticState createState() => _GeneticState();
}

class _GeneticState extends State<Genetic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Genetic"),
        backgroundColor: Colors.redAccent[400],
      ),
      body: new GeneticWidget(),
    );
  }
}

class GeneticWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GeneticWidgetState();
}

class GeneticWidgetState extends State<GeneticWidget> {
  final _formKey = GlobalKey<FormState>();
  int a, b, c, d, res;
  int maxPop;
  int maxItr;
  var time;
  dynamic result;
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Row(
                children: [
                  Container(padding:EdgeInsets.all(8.0),
                      child: new Text('Number   of   iteration:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                  Expanded(
                      child:
                      Container(padding:EdgeInsets.all(8.0),
                          child:
                          TextFormField(
                            validator: (value) {
                              if(value == null){return null;}
                              maxItr = num.tryParse(value);
                              if(maxItr == null){return 'Error';}
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
                      child: new Text('Number of population:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                  Expanded(
                      child:
                      Container(
                          padding:EdgeInsets.all(8.0),
                          child:
                          TextFormField(
                            validator: (value) {
                              if(value == null){return null;}
                              maxPop = num.tryParse(value);
                              if(maxPop == null){return 'Error';}
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
                  Container(padding:EdgeInsets.all(8.0),
                        child: Text('a:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                    Expanded(
                        child:
                        Container(padding:EdgeInsets.all(8.0),
                            child:
                            TextFormField(
                              validator: (value) {
                                if(value == null){return null; }
                                a = num.tryParse(value);
                                if(a == null){return 'Error';}
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            )
                        )
                    ),
                    Container(padding:EdgeInsets.all(8.0),
                        child: Text('b:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                    Expanded(
                        child:
                        Container(padding:EdgeInsets.all(8.0),
                            child:
                            TextFormField(
                              validator: (value) {
                                if(value == null){ return null;}
                                b = num.tryParse(value);
                                if(b == null){return 'Error';}
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
                    
                    Container(padding:EdgeInsets.all(8.0),
                        child: Text('c:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                    Expanded(
                        child:
                        Container(padding:EdgeInsets.all(8.0),
                            child:
                            TextFormField(
                              validator: (value) {
                                if(value == null){ return null;}
                                c = num.tryParse(value);
                                if(c == null){return 'Error';}
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            )
                        )
                    ),
                    Container(padding:EdgeInsets.all(8.0),
                        child: Text('d:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                    Expanded(
                        child:
                        Container(padding:EdgeInsets.all(8.0),
                            child:
                            TextFormField(
                              validator: (value) {
                                if(value == null){return null; }
                                d = num.tryParse(value);
                                if(d == null){ return 'Error';}
                                return null;},
                              keyboardType: TextInputType.number,
                            )
                        )
                    ),
                  ]
              ),
              Container(padding:EdgeInsets.all(8.0),
                        child: Text('result:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)),
                    Align(
                        child:
                        Container(padding:EdgeInsets.all(15.0), height: 50,
                            child:
                            TextFormField(
                              validator: (value) {
                                if(value == null){ return null;}
                                res = num.tryParse(value);
                                if(res == null){return 'Error';}
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            )
                        )
                    ),
              Container(
                alignment: Alignment.center,
                padding:EdgeInsets.all(10.0),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  onPressed: (){
                    if(_formKey.currentState.validate()){
                      setState(() {
                        var timer = Stopwatch();
                        timer.start();
                        result = solve([a, b, c, d, res], maxItr, maxPop, 0.05, false);
                        timer.stop();
                        time = timer.elapsedMilliseconds;
                      });
                    }},
                  child: Text('Confirm'),
                  color: Colors.redAccent[400], textColor: Colors.black,
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                alignment: Alignment.center,
                child: Text(result == null ? '' : '[[x1, x2, x3, x4], iterations] = \n       = $result', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
              ),
              SizedBox(height: 20.0),
              Container(
                alignment: Alignment.center,
                child: Text(time == null ? '' : 'Time = $time ms', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),)
              ),
            ]
        )
    );
  }
} 

//Generic algorithm realization

List<List<int>> generatePopulation(int y, int len, int maxPop){
  List<List<int>> population = List.generate(maxPop, (index) => List.generate(len, (index) => Random().nextInt((y).ceil())));
  return population;
}

int fitness(List<int> gen, List<int> data){
  int y = data.last;
  int sum = 0;
  for(int i = 0; i < gen.length; i++){
    sum += ((gen[i] * data[i]));
  }
  return (sum - y).abs();
}

List<int> createFitness(List<List<int>> population, List<int> data){
  int len = population.length;
  return List.generate(len, (index) => fitness(population[index], data));
}

List<double> generateLikelihoods(List<int> fitnesses){
  int len = fitnesses.length;
  dynamic last = 0;
  double mul = fitnesses.map((e) => 1/e).toList().reduce((value, element) => value + element);
  List<double> res = List.filled(len, 0);
  for(int i = 0; i < len; i++){
    res[i] = (last + (1/fitnesses[i])/mul);
    last = res[i];
  }
  return res;
}

int getIndex(double val, List<List<int>> population, List<double>likelihood, bool bad) {
  double last = 0;
  int len = population.length;
  if(bad == true){
    double last = 1;
    int len = population.length;
    for(int i = 0; i < len; i++) {
      if (likelihood[i] <= val && val <= last) return i;
      }
      return len - 1;
  }
  for(int i = 0; i < len; i++) {
    if (last <= val && val <= likelihood[i]) return i;
    else last = likelihood[i];
  }
  return len - 1;
}

List<List<int>> createNewPopulation(List<List<int>> population, List<double>likelihood, int y, double chance, bool bad){
  int len = population.length;
  for(int i = 0; i < len; i++) {
    int parent1 = 0, parent2 = 0, iterations = 0;
    while(parent1 == parent2 || population[parent1] == population[parent2]){
      parent1 = getIndex((Random().nextDouble()), population, likelihood, bad);
      parent2 = getIndex((Random().nextDouble()), population, likelihood, bad);
      if (++iterations > (pow(len, 2))) break;
    }
    population[i] = crossover(population[parent1], population[parent2], y, chance);
  }
  return population;
}

List<int> crossover(List<int> p1, List<int> p2, int y, double chance) {
  int len = p1.length;
  int flag = Random().nextInt(len);
  List<int> child = List.filled(len, 0);
  for(int i = 0; i < len; i++) {
    if(flag < i){
      child[i] = p1[i];
    }
    child[i] = p2[i];
    if (Random().nextDouble() < chance) child[i] = Random().nextInt(y);
  }
  return child;
}

dynamic solve(List<int> data, int maxItr, int maxPop, double chance, bool bad){
  int len = data.length - 1;
  int y = data.last;
  int numberPop = 0;
  List<List<int>> population = generatePopulation(y, len, maxPop);
  while(maxItr > 0){
    List<int> fitnesses = createFitness(population, data);
    int i = fitnesses.indexOf(0);
    if(i != -1){
      return [population[i], numberPop];
    }
    List<double> likelihood = generateLikelihoods(fitnesses);
    List<List<int>> child = createNewPopulation(population, likelihood, y, chance, bad);
    numberPop++;
    population = child;
    maxItr--;
  }
  return ["Max iterations", numberPop];
}