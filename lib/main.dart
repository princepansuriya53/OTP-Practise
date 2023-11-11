import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Loginwithphone.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: homepage()),
  );
}

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select option'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Enter'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Logineithphone()));
              },
            )
          ],
        ),
      ),
    );
  }
}
