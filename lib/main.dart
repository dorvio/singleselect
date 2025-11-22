import 'package:flutter/material.dart';
import 'package:singleselect/singleselect.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleSelectFormField(
          items: ['TAK', 'NIE'],
          inputDecoration: InputDecoration(
            labelText: "Wybór",
            labelStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(Icons.location_on, color: Colors.grey),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.pink, width: 2),
            ),
          ),
          optionListBackgroundColor: Colors.white,
          optionListTextColor: Colors.grey,
        )
      ),
    );
  }
}
