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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              //controller: _usernameController,
              style: const TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                labelText: "Nazwa wydarzenia",
                labelStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.edit, color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink, width: 2),
                ),
              ),
            ),
            SingleSelectFormField(
              items: ['TAK', 'NIE'],
              optionListBackgroundColor: Colors.white,
              selectedTextStyle: const TextStyle(color: Colors.grey),
              inputDecoration: const InputDecoration(
                labelText: "Wybór",
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(Icons.location_on, color: Colors.grey),
                border: UnderlineInputBorder(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink, width: 2),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
