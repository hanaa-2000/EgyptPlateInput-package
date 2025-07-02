import 'dart:developer';

import 'package:egypt_plate_input/egypt_plate_input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: ' زنقة (Zanqa)',
      // //darkTheme: ThemeData.dark(
      //
      // ),
      theme: ThemeData(
        useMaterial3: true,
        //  primaryColor: AppColors.primaryColor,
        // scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrangeAccent.shade200,
        ),
        fontFamily: "Alexandria",

        // brightness: Brightness.dark
      ),

      // supportedLocales: const [Locale('ar')],
      locale: const Locale('ar'),

      home: PlateDemoScreen(),
    );
  }
}

class PlateDemoScreen extends StatefulWidget {
  const PlateDemoScreen({super.key});

  @override
  State<PlateDemoScreen> createState() => _PlateDemoScreenState();
}

class _PlateDemoScreenState extends State<PlateDemoScreen> {
  final field1Controller = TextEditingController();
  final field2Controller = TextEditingController();
  final field3Controller = TextEditingController();
  final numberController = TextEditingController();

  @override
  void dispose() {
    field1Controller.dispose();
    field2Controller.dispose();
    field3Controller.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('تجربة لوحة عربية'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EgyptPlateInput(
                field1Controller: field1Controller,
                field2Controller: field2Controller,
                field3Controller: field3Controller,
                numberController: numberController,
                background: Colors.grey,
                hintStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black26,
                  fontWeight: FontWeight.bold,
                ),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                onPlateChanged: (plate) {
                  log("اللوحة الجديدة: $plate");
                },
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  final plate =
                      "${field1Controller.text}${field2Controller.text}${field3Controller.text}-${numberController.text}";
                  print("رقم اللوحة: $plate");
                },
                child: const Text("طباعة اللوحة"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
