import 'package:flutter_listin/products/model/product.dart';
import 'package:test/test.dart';

void main() {
  group('Testes da Classe Product', () {
    // Testando o construtor padrão
    test('Construtor deve inicializar as propriedades corretamente', () {
      final product = Product(
        id: '1',
        name: 'Produto Teste',
        obs: 'Observação de teste',
        category: 'Categoria Teste',
        isKilograms: false,
        isPurchased: false,
        price: 20.0,
        amount: 5.0,
      );

      expect(product.id, equals('1'));
      expect(product.name, equals('Produto Teste'));
      expect(product.obs, equals('Observação de teste'));
      expect(product.category, equals('Categoria Teste'));
      expect(product.isKilograms, isFalse);
      expect(product.isPurchased, isFalse);
      expect(product.price, equals(20.0));
      expect(product.amount, equals(5.0));
    });

    // Testando a inicialização via mapa
    test('fromMap deve inicializar as propriedades corretamente', () {
      Map<String, dynamic> data = {
        'id': '2',
        'name': 'Produto 2',
        'obs': 'Observação do produto 2',
        'category': 'Categoria 2',
        'isKilograms': true,
        'isPurchased': true,
        'price': 30.0,
        'amount': 10.0
      };
      final product = Product.fromMap(data);

      expect(product.id, equals('2'));
      expect(product.name, equals('Produto 2'));
      expect(product.obs, equals('Observação do produto 2'));
      expect(product.category, equals('Categoria 2'));
      expect(product.isKilograms, isTrue);
      expect(product.isPurchased, isTrue);
      expect(product.price, equals(30.0));
      expect(product.amount, equals(10.0));
    });

    // Testando serialização para mapa
    test('toMap deve serializar as propriedades corretamente', () {
      final product = Product(
        id: '3',
        name: 'Produto 3',
        obs: 'Observação 3',
        category: 'Categoria 3',
        isKilograms: false,
        isPurchased: true,
        price: 15.0,
        amount: 3.5,
      );
      Map<String, dynamic> data = product.toMap();

      expect(data['id'], equals('3'));
      expect(data['name'], equals('Produto 3'));
      expect(data['obs'], equals('Observação 3'));
      expect(data['category'], equals('Categoria 3'));
      expect(data['isKilograms'], isFalse);
      expect(data['isPurchased'], isTrue);
      expect(data['price'], equals(15.0));
      expect(data['amount'], equals(3.5));
    });

    // Testando validações básicas (exemplo: campos obrigatórios)
    test(
        'deve lançar uma exceção se algum campo obrigatório estiver ausente no fromMap',
        () {
      expect(
        () => Product.fromMap({
          'id': '4',
          'name': 'Produto 4',
          // 'category' is missing
          'isKilograms': true,
          'isPurchased': true,
          'price': 25.0,
          'amount': 1.5,
        }),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
