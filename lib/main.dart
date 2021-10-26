import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorApp(),
    );
  }
}


class CalculatorApp extends StatefulWidget {
  //const ({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<CalculatorApp> {
  String calculationResult = "0";
  String equation = "0";
  String expression = "";

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == 'AC'){
        equation = "0";
        calculationResult = "0";

      }else if(buttonText == 'DEL'){
        equation = equation.substring(0, equation.length -1);
        if(equation == ""){
          equation = "0";
        }

      }else if(buttonText == 'Ans'){

        expression = equation;
        expression = expression.replaceAll('X', '*');
        expression = expression.replaceAll('/', '/');

        try{

          Parser P =  Parser();
          Expression exp = P.parse(expression);
          ContextModel cm = ContextModel();
          calculationResult = '${exp.evaluate(EvaluationType.REAL, cm)}';

        }catch(e){
          calculationResult = "Error";
        }

      }else {
        if (equation == "0") {
          equation = buttonText;
        }
        else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText){
    return Container(
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator",
        style: TextStyle(
          fontSize: 30,
        ),),
        backgroundColor: Colors.black12,
      ),

      body:Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            height: 100,
            width: 425,
            color: Colors.blueAccent,
            child: Text(equation,
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top:10, ),
            height: 100,
            width: 425,
            color: Colors.blueAccent,
            child: Text(calculationResult,
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
          ),

          SizedBox(height: 50,),

          Container(
            height: 70,
            //color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("9"),
                buildButton("8"),
                buildButton("7"),
                buildButton("AC"),
                buildButton("DEL"),
              ],
            ),
          ),

          Container(
            height: 70,
            //color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("6"),
                buildButton("5"),
                buildButton("4"),
                buildButton("X"),
                buildButton("/"),
              ],
            ),
          ),

          Container(
            height: 70,
            //color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("3"),
                buildButton("2"),
                buildButton("1"),
                buildButton("+"),
                buildButton("-"),
              ],
            ),
          ),

          Container(
            height: 70,
            //color: Colors.green,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildButton("0"),
                buildButton("."),
                buildButton("00"),
                buildButton("%"),
                buildButton("Ans"),
              ],
            ),
          ),

        ],
      )
    );
  }
}
