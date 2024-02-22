// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> symblos = [
    "C",
    "Del",
    "%",
    "/",
    "9",
    "8",
    "7",
    "*",
    "6",
    "5",
    "4",
    "+",
    "3",
    "2",
    "1",
    "-",
    ".",
    "0",
    "Ans",
    "=",
  ];
  String input = " ";
  String output = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Calculator"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(5),
              width: double.infinity,
              child: Text(
                input,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.all(5),
              width: double.infinity,
              child: Text(
                output,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: GridView.builder(
                itemCount: symblos.length,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (symblos[index] == "C") {
                        setState(() {
                          input = " ";
                          output = " ";
                        });
                      } else if (symblos[index] == "Del") {
                        setState(() {
                          input = input.substring(0, input.length - 1);
                        });
                      } else if (symblos[index] == "Ans") {
                        setState(() {
                          input = output;
                          output = "  ";
                        });
                      } else if (symblos[index] == "%" ||
                          symblos[index] == "/" ||
                          symblos[index] == "*" ||
                          symblos[index] == "+" ||
                          symblos[index] == "-") {
                        if (input.endsWith("%") ||
                            input.endsWith("/") ||
                            input.endsWith("*") ||
                            input.endsWith("+") ||
                            input.endsWith("-")) {
                        } else {
                          setState(() {
                            input += symblos[index];
                          });
                        }
                      } else if (symblos[index] == "=") {
                        Expression exp = Parser().parse(input);
                        double result =
                            exp.evaluate(EvaluationType.REAL, ContextModel());
                        setState(() {
                          output = result.toString();
                        });
                      } else {
                        setState(() {
                          input += symblos[index];
                        });
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: myBackgroundColor(symblos[index]),
                        borderRadius: BorderRadius.circular( 20)
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        symblos[index],
                        style: TextStyle(
                          color: myTextColor(symblos[index]),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),




                  );
                }),
          ),
        ],
      ),
    );
  }

  Color  myBackgroundColor(String x){
    if(x=="C"){
      return Colors.teal.shade300;
    }else if(x=="Del"){
      return Colors.red;
    }else if(x=="%"||x=="/"||x=="+"||x=="*"||x=="-"||x=="="){
     return Colors.blue.shade400;
    }else{
      return Colors.grey.shade300;
    }
  }
  Color myTextColor(String x){
    if(x=="C"||x=="%"||x=="Del"||x=="/"||x=="+"||x=="*"||x=="-"||x=="="){
      return Colors.white;
    }  else{
      return Colors.black;
    }

  }

}
