import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/intro_page.dart';
import 'package:online_sale_client/online_sale_client.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => OnlineSaleClient(host: 'http://192.168.1.49:8000'),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
      ),
    );
  }
}
