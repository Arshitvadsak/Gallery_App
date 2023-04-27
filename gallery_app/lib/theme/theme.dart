import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isDarkModeEnabled = false;

  @override
  Widget build(BuildContext context) {

    final ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    );

    final ThemeData darkTheme = ThemeData(
      primarySwatch: Colors.deepPurple,
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'MyApp',
      theme: isDarkModeEnabled ? darkTheme : lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('MyApp'),
        ),
        body: Center(
          child: Text(
            'Hello, World!',
            style: TextStyle(fontSize: 32),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.brightness_medium),
          onPressed: () {
            setState(() {
              isDarkModeEnabled = !isDarkModeEnabled;
            });
          },
        ),
      ),
    );
  }
}
