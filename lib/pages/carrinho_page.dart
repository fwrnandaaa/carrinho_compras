import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ models/carrinho_model.dart';

class CarrinhoPage extends StatelessWidget {
  const CarrinhoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cores.primaryContainer,
        // Widget que reage ao estado: título com a quantidade
        title: Consumer<CarrinhoModel>(
          builder: (context, carrinho, _) => Text(
            'Meu carrinho (${carrinho.quantidade})',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Consumer<CarrinhoModel>(
            builder: (context, carrinho, _) => IconButton(
              onPressed: carrinho.vazio ? null : carrinho.limpar,
              icon: const Icon(Icons.delete_sweep),
              tooltip: 'Limpar carrinho',
            ),
          ),
        ],
      ),
      // Widget que reage ao estado: lista de itens
      body: Consumer<CarrinhoModel>(
        builder: (context, carrinho, _) {
          if (carrinho.vazio) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.remove_shopping_cart,
                      size: 64, color: cores.outline),
                  const SizedBox(height: 12),
                  const Text('Seu carrinho está vazio'),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: carrinho.itens.length,
            itemBuilder: (context, index) {
              final produto = carrinho.itens[index];
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
                  trailing: IconButton(
                    onPressed: () => carrinho.remover(produto),
                    icon: Icon(Icons.remove_circle, color: cores.error),
                  ),
                ),
              );
            },
          );
        },
      ),
      // Widget que reage ao estado: total e botão
      bottomNavigationBar: Consumer<CarrinhoModel>(
        builder: (context, carrinho, _) => Container(
          color: cores.primaryContainer,
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Total: R\$ ${carrinho.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: carrinho.vazio ? null : () {},
                  child: const Text('Finalizar compra'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}