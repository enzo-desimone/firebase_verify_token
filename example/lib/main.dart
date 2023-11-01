import 'package:firebase_verify_token/firebase_verify_token.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController tx = TextEditingController();
  final ValueNotifier<bool?> verified = ValueNotifier(null);

  @override
  void initState() {
    FirebaseVerifyToken.projectId = 'intech-52fc1';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Firebase verify token example'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: tx,
                    minLines: 5,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintText: 'Copy your firebase jwt token',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (tx.text.isNotEmpty) {
                          verified.value =
                              await FirebaseVerifyToken.verify(tx.text);
                        }
                      },
                      child: const Text('Verify token!')),
                  const SizedBox(
                    height: 20,
                  ),
                  ValueListenableBuilder(
                    valueListenable: verified,
                    builder:
                        (BuildContext context, bool? value, Widget? child) {
                      if (value == null) {
                        return Container();
                      }

                      return Text(
                        value ? 'Verified' : 'NOT Verified',
                        style: TextStyle(
                            fontSize: 16,
                            color: value ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w700),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
