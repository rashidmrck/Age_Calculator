import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.pink),
      title: 'Age Calculator',
      home: AgeCalculator(),
    );
  }
}

class AgeCalculator extends StatefulWidget {
  @override
  _AgeCalculatorState createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator>
    with SingleTickerProviderStateMixin {
  var selectedYear = DateTime.now();
  var year;
  double age = 1.0;
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation = animationController;
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Calculator'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              OutlineButton(
                borderSide: BorderSide(width: 2),
                onPressed: () {
                  _datePicker();
                },
                child: Text(year == null
                    ? 'Slect Your Year of Birth'
                    : year.toString()),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Text(
                        'Your Age is ${animation.value.toStringAsFixed(0)}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: selectedYear,
            firstDate: DateTime(1900),
            lastDate: DateTime.now())
        .then((DateTime dt) {
      setState(() {
        selectedYear = dt;
        year = selectedYear.year;
        calculateage();
      });
    });
  }

  void calculateage() {
    setState(() {
      age = (DateTime.now().year - year).toDouble();
      animation = Tween<double>(begin: animation.value, end: age).animate(
          CurvedAnimation(
              curve: Curves.fastOutSlowIn, parent: animationController));
      selectedYear = DateTime.now();
      animationController.forward(from: 0.0);
    });
  }
}
