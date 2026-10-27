import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import ' models/carrinho_model.dart';
import 'pages/loja_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CarrinhoModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carrinho de Compras',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const LojaPage(),
    );
  }
}