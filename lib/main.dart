import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Iphone',
      theme: ThemeData(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget { //class calculator adalah widget stateful karna memiliki nilai yang selalu berubah ketika tombolnya di tekan
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String output = '0'; // output merupakan variabel yang menampung nilai yang akan ditampilkan di kalkulator

  void buttonPressed(String buttonText) { // fungsi buttonPressed yang akan dipanggil ketika tombol di tekan
    setState(() {
      if (buttonText == "C") { // jika tombol "C" di tekan, maka output diubah menjadi 0
        output ="0";
      }
      else if (buttonText == "=") { // jika tombol "=" di tekan, maka output diubah menjadi hasil dari expression
        try {
          output = evaluateExpression(
            output.replaceAll('x', '*')); // evaluateExpression adalah fungsi yang digunakan untuk menghiting hasil dari expression
        } catch (e) { //catch digunakan untuk menangani kesalahan ysng terjadi ketika menghitung expression (contohnya jika user memasukkan fungsi yg tidak falid seperti 1++2 atau hanya +)
          output = "Error";
        }
      } else {
        if (output == "0") { 
          output = buttonText;
        } else {
          output += buttonText;
        }
      }
    });
  }

  String evaluateExpression(String expression) { //fungsi ini digunakan untuk mengonversi expression menjadi hasil perhitungan, fungsi ini diambil dari expression.dart
    final parsedExpression = Expression.parse(expression); //digunakan untuk mengonversi string menjadi expression yang dipahami oleh komputer
    final evaluator = ExpressionEvaluator(); //
    final result = evaluator.eval(parsedExpression,{}); //digunakan untuk mengevaluasi expression dan mengembalikan nilai sbg string
    return result.toString(); //pengembalian nilai ke string
  }

  Widget buildButton(String buttonText, Color color, {double
  widthFactor = 1.0}) { //fungsi ini digunakan untuk membuat widget tombol pada kalkulator dgn teks, warna, dan ukuran yg ditentukan
    return Expanded( //membuat tombol yang mengisi ruang horizontal yang tersedia dalam 1 baris atau kolom
      flex: widthFactor.toInt(), //widthFactor digunakan untuk mengatur lebar tombol menjadi 1flex digunakan untuk menentukan proporsi lebar tombol dlm baris
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:  ElevatedButton( //digunakan untuk membuat tombol dg gaya tertentu
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 22), //digunakan untuk mengatur jarak dlm tombol scr vertikal menjadi 22 sehingga tombol terlihat tinggi
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0), //digunakan untuk membuat sudut tombol melengkung dg radius 40
            ),
            elevation: 0, //mengatur bayangan tombol menjadi 0 dan tampak datar
          ),
          onPressed: () => buttonPressed(buttonText), //digunakan untuk memanggil fungsi buttonPressed ketika tombol di tekan
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
        ),
      ),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 24, bottom: 24),
              alignment: Alignment.bottomRight,
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ),  
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  buildButton("C", Colors.grey.shade600),
                  buildButton("+/-", Colors.grey.shade600),
                  buildButton("%", Colors.grey.shade600),
                  buildButton("/", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("7", Colors.grey.shade600),
                  buildButton("8", Colors.grey.shade600),
                  buildButton("9", Colors.grey.shade600),
                  buildButton("x", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("4", Colors.grey.shade600),
                  buildButton("5", Colors.grey.shade600),
                  buildButton("6", Colors.grey.shade600),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: <Widget>[
                  buildButton("1", Colors.grey.shade600),
                  buildButton("2", Colors.grey.shade600),
                  buildButton("3", Colors.grey.shade600),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row (
                children: <Widget>[
                  buildButton("0", Colors.grey.shade800, widthFactor: 2), //widthFactor untuk menggabungn 2 kotak jadi 1
                  buildButton(".", Colors.grey.shade800),
                  buildButton("=", Colors.orange),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}