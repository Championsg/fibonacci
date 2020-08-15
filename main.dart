import 'package:flutter/material.dart';

void main() {
  final numbers = FibonacciNumbers();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fibonacci List'),
        ),
        body: FibonacciListView(numbers),
      ),
    ),
  );
}
class FibonacciNumbers {
  final memo = {0: BigInt.from(1), 1: BigInt.from(1)};
  BigInt get(int i){
    if (!memo.containsKey(i)) {
      memo[i] = get(i - 1) + get(i - 2);
    }
    return memo[i];
  }
}
class FibonacciListView extends StatelessWidget {
  final FibonacciNumbers numbers;
  FibonacciListView(this.numbers);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i){
        return ListTile(
          title: Text('${numbers.get(i)}'),
          onTap: () {
            addDialog(context,i,numbers);
          },
        );
      },
    );
  }
}
Future<bool> addDialog(BuildContext context,int i,FibonacciNumbers numbers) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.cyanAccent,
        title: Text('${numbers.get(i)} is '
            '#$i in the Fibonacci sequence!'),
        actions: <Widget>[
          FlatButton(
            child: Text('Great!'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          )
        ],
      );
    }
  );
}