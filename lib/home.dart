import 'package:flutter/material.dart';

class HomeCalc extends StatefulWidget {
  const HomeCalc({super.key});

  @override
  State<HomeCalc> createState() => _HomeCalcState();
}

class _HomeCalcState extends State<HomeCalc> {
  dynamic displaytxt = 20;

//button widget

  Widget calculaterbut(String buttxt, Color butcol, Color txtcol) {
    return Container(
      color: butcol,
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          calculaterbut(buttxt, butcol, txtcol);
        },
        child: Text(
          buttxt,
          style: TextStyle(
            fontSize: 35,
            color: txtcol,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("calculater"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$text',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculaterbut('AC', Colors.grey, Colors.black),
                calculaterbut('+/-', Colors.grey, Colors.black),
                calculaterbut('%', Colors.grey, Colors.black),
                calculaterbut('/', Colors.amberAccent, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculaterbut('7', Colors.grey, Colors.white),
                calculaterbut('8', Colors.grey, Colors.white),
                calculaterbut('9', Colors.grey, Colors.white),
                calculaterbut('x', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculaterbut('4', Colors.grey, Colors.white),
                calculaterbut('5', Colors.grey, Colors.white),
                calculaterbut('6', Colors.grey, Colors.white),
                calculaterbut('-', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calculaterbut('1', Colors.grey, Colors.white),
                calculaterbut('2', Colors.grey, Colors.white),
                calculaterbut('3', Colors.grey, Colors.white),
                calculaterbut('+', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //this is button Zero
                Padding(
                  padding: const EdgeInsets.fromLTRB(34, 20, 128, 20),
                  child: ElevatedButton(
                    onPressed: () {
                      calculation('0');
                    },
                    child: const Text('0', style: TextStyle(fontSize: 35, color: Colors.white)),
                  ),
                ),
                calculaterbut('.', Colors.grey, Colors.white),
                calculaterbut('=', Colors.amber, Colors.white),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
  //Calculator logic

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  void calculation(buttxt) {
    if (buttxt == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && buttxt == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (buttxt == '+' || buttxt == '-' || buttxt == 'x' || buttxt == '/' || buttxt == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = buttxt;
      result = '';
    } else if (buttxt == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (buttxt == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (buttxt == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1) : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + buttxt;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) return result = splitDecimal[0].toString();
    }
    return result;
  }
}
