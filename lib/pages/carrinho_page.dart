import 'package:flutter/material.dart';
import '../ models/produto.dart';

class CarrinhoPage extends StatelessWidget {
  // Tudo abaixo vem "de cima" (do main.dart) pelo construtor
  final List<Produto> carrinho;
  final void Function(Produto) onRemover;
  final VoidCallback onLimpar;

  const CarrinhoPage({
    super.key,
    required this.carrinho,
    required this.onRemover,
    required this.onLimpar,
  });

  // Soma o preço de todos os itens do carrinho
  double get total => carrinho.fold(0, (soma, p) => soma + p.preco);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho (${carrinho.length})'),
        actions: [
          IconButton(
            onPressed: onLimpar,
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Limpar carrinho',
          ),
        ],
      ),
      body: carrinho.isEmpty
          ? const Center(child: Text('Seu carrinho está vazio'))
          : ListView.builder(
        itemCount: carrinho.length,
        itemBuilder: (context, index) {
          final produto = carrinho[index];
          return ListTile(
            title: Text(produto.nome),
            subtitle: Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
            trailing: IconButton(
              onPressed: () => onRemover(produto),
              icon: const Icon(Icons.remove_circle),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Total: R\$ ${total.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}