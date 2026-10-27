import 'package:flutter/material.dart';
import '../ models/produto.dart';

// Agora é StatefulWidget só para conseguir se redesenhar sozinha
class CarrinhoPage extends StatefulWidget {
  final List<Produto> carrinho;
  final void Function(Produto) onRemover;
  final VoidCallback onLimpar;

  const CarrinhoPage({
    super.key,
    required this.carrinho,
    required this.onRemover,
    required this.onLimpar,
  });

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  double get total =>
      widget.carrinho.fold<double>(0, (soma, p) => soma + p.preco);

  // Avisa o main.dart E redesenha esta tela
  void _remover(Produto produto) {
    widget.onRemover(produto);
    setState(() {});
  }

  void _limpar() {
    widget.onLimpar();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final carrinho = widget.carrinho;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cores.primaryContainer,
        title: Text(
          'Meu carrinho (${carrinho.length})',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: carrinho.isEmpty ? null : _limpar,
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Limpar carrinho',
          ),
        ],
      ),
      body: carrinho.isEmpty
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.remove_shopping_cart,
                size: 64, color: cores.outline),
            const SizedBox(height: 12),
            const Text('Seu carrinho está vazio'),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: carrinho.length,
        itemBuilder: (context, index) {
          final produto = carrinho[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading:
              const CircleAvatar(child: Icon(Icons.shopping_bag)),
              title: Text(
                produto.nome,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
              Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
              trailing: IconButton(
                onPressed: () => _remover(produto),
                icon: Icon(Icons.remove_circle, color: cores.error),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: cores.primaryContainer,
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Total: R\$ ${total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FilledButton(
                onPressed: carrinho.isEmpty ? null : () {},
                child: const Text('Finalizar compra'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}