import 'package:flutter/material.dart';
import ' models/produto.dart';
import 'pages/loja_page.dart';
import 'pages/carrinho_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrinho de Compras',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const HomeController(),
    );
  }
}

// Este widget guarda o estado do carrinho (versão com setState)
class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  // O estado: a lista de produtos no carrinho
  final List<Produto> carrinho = [];

  void adicionar(Produto produto) {
    setState(() {
      carrinho.add(produto);
    });
  }

  void remover(Produto produto) {
    setState(() {
      carrinho.remove(produto);
    });
  }

  void limpar() {
    setState(() {
      carrinho.clear();
    });
  }

  void abrirCarrinho() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CarrinhoPage(
          carrinho: carrinho,
          onRemover: remover,
          onLimpar: limpar,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LojaPage(
      carrinho: carrinho,
      onAdicionar: adicionar,
      onAbrirCarrinho: abrirCarrinho,
    );
  }
}