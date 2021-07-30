import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_gradients/flutter_gradients.dart';

void main() => runApp(calculator());

class calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Final Assignment',
      home: myCalculator(),
    );
  }
}

class myCalculator extends StatefulWidget {
  @override
  calculatorState createState() => calculatorState();
}

class calculatorState extends State<myCalculator> {
  String expr = "";
  double equationFont = 35;
  double resultFont = 45;
  String equation = "0";
  String result = "0";
  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFont = 35;
        resultFont = 45;
      }
      else if(buttonText == "⌫"){
        equationFont = 45;
        resultFont = 35;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        equationFont = 35;
        resultFont = 45;
        expr = equation;
        expr = expr.replaceAll('×', '*');
        expr = expr.replaceAll('÷', '/');
        try{
          Parser p = Parser();
          Expression exp = p.parse(expr);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Expression Error";
        }
      }
      else{
        equationFont = 45;
        resultFont = 35;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }
  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white,
                  width: 2,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(15.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontFamily: 'Pacifico',
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
          title: Text('Final Assignment - Calculator',style: TextStyle(
          fontFamily: 'Pacifico',
          fontWeight: FontWeight.bold,
          ),
          ),
          flexibleSpace: Container(
      decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        Colors.black,
        Colors.black54,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight)
      ),
    )
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFont),),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFont),),
          ),

          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("C", 1, Colors.red),
                          buildButton("⌫", 1, Colors.blueAccent),
                          buildButton("÷", 1, Colors.blueAccent),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("7", 1, Colors.black87),
                          buildButton("8", 1, Colors.black87),
                          buildButton("9", 1, Colors.black87),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("4", 1, Colors.black87),
                          buildButton("5", 1, Colors.black87),
                          buildButton("6", 1, Colors.black87),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("1", 1, Colors.black87),
                          buildButton("2", 1, Colors.black87),
                          buildButton("3", 1, Colors.black87),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton(".", 1, Colors.black87),
                          buildButton("0", 1, Colors.black87),
                          buildButton("00", 1, Colors.black87),
                        ]
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("×", 1, Colors.blueAccent),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.blueAccent),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.blueAccent),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.red),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}