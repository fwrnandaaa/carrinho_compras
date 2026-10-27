import 'package:flutter/foundation.dart';
import 'produto.dart';

class CarrinhoModel extends ChangeNotifier {
  final List<Produto> _itens = [];

  // Leitura da lista sem permitir alteração por fora
  List<Produto> get itens => List.unmodifiable(_itens);

  int get quantidade => _itens.length;

  double get total => _itens.fold<double>(0, (soma, p) => soma + p.preco);

  bool get vazio => _itens.isEmpty;

  void adicionar(Produto produto) {
    _itens.add(produto);
    notifyListeners();
  }

  void remover(Produto produto) {
    _itens.remove(produto);
    notifyListeners();
  }

  void limpar() {
    _itens.clear();
    notifyListeners();
  }
}