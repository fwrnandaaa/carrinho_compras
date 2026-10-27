import 'package:flutter/material.dart';
import '../ models/produto.dart';

class LojaPage extends StatelessWidget {
  static const List<Produto> produtos = [
    Produto(id: 1, nome: 'Camiseta', preco: 49.90),
    Produto(id: 2, nome: 'Calça Jeans', preco: 129.90),
    Produto(id: 3, nome: 'Tênis', preco: 249.90),
    Produto(id: 4, nome: 'Boné', preco: 39.90),
    Produto(id: 5, nome: 'Mochila', preco: 89.90),
  ];

  final List<Produto> carrinho;
  final void Function(Produto) onAdicionar;
  final VoidCallback onAbrirCarrinho;

  const LojaPage({
    super.key,
    required this.carrinho,
    required this.onAdicionar,
    required this.onAbrirCarrinho,
  });

  // Total calculado a partir da lista do carrinho
  double get total => carrinho.fold<double>(0, (soma, p) => soma + p.preco);

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;
    final qtd = carrinho.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cores.primaryContainer,
        title: const Text(
          'Vitrine Urbana',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: const CircleAvatar(child: Icon(Icons.shopping_bag)),
              title: Text(
                produto.nome,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
              trailing: FilledButton(
                onPressed: () {
                  onAdicionar(produto);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${produto.nome} adicionado!'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: const Text('Adicionar'),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Barra do carrinho: quantidade + total + botão
          Container(
            color: cores.primaryContainer,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Icon(Icons.shopping_cart),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$qtd ${qtd == 1 ? 'item' : 'itens'}'),
                      Text(
                        'Total: R\$ ${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: carrinho.isEmpty ? null : onAbrirCarrinho,
                  child: const Text('Ver carrinho'),
                ),
              ],
            ),
          ),
          // Barra de navegação (só visual, sem função)
          NavigationBar(
            selectedIndex: 0,
            onDestinationSelected: (_) {},
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Início'),
              NavigationDestination(icon: Icon(Icons.search), label: 'Buscar'),
              NavigationDestination(
                icon: Icon(Icons.favorite_border),
                label: 'Favoritos',
              ),
              NavigationDestination(icon: Icon(Icons.person), label: 'Perfil'),
            ],
          ),
        ],
      ),
    );
  }
}