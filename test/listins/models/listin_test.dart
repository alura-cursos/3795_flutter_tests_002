import 'package:test/test.dart';
import "package:flutter_listin/listins/models/listin.dart";

void main() {
  group('Listin Class Tests', () {
    // Testando o construtor padrão
    test('Construtor inicializa propriedades corretamente', () {
      DateTime currentDateTime = DateTime.now();
      final listin = Listin(
        id: '1',
        name: 'Item Test',
        obs: 'Observação de teste',
        dateCreate: currentDateTime,
        dateUpdate: currentDateTime,
      );

      expect(listin.id, equals('1'));
      expect(listin.name, equals('Item Test'));
      expect(listin.obs, equals('Observação de teste'));
      expect(listin.dateCreate, equals(currentDateTime));
      expect(listin.dateUpdate, equals(currentDateTime));
    });

    // Testando a inicialização via mapa
    test('fromMap inicializa propriedades corretamente', () {
      Map<String, dynamic> data = {
        'id': '2',
        'name': 'Item 2',
        'obs': 'Observação do item 2',
        'dateCreate': '2023-05-01T14:00:00Z',
        'dateUpdate': '2023-05-01T15:00:00Z',
      };
      final listin = Listin.fromMap(data);

      expect(listin.id, equals('2'));
      expect(listin.name, equals('Item 2'));
      expect(listin.obs, equals('Observação do item 2'));
      expect(listin.dateCreate, DateTime.parse(data['dateCreate']));
      expect(listin.dateUpdate, DateTime.parse(data['dateUpdate']));
    });

    // Testando a serialização para mapa
    test('toMap serializa propriedades corretamente', () {
      DateTime currentDateTime = DateTime.now();
      final listin = Listin(
        id: '3',
        name: 'Item 3',
        obs: 'Observação 3',
        dateCreate: currentDateTime,
        dateUpdate: currentDateTime,
      );
      Map<String, dynamic> data = listin.toMap();

      expect(data['id'], equals('3'));
      expect(data['name'], equals('Item 3'));
      expect(data['obs'], equals('Observação 3'));
      expect(data['dateCreate'], equals(currentDateTime.toString()));
      expect(data['dateUpdate'], equals(currentDateTime.toString()));
    });

    // Testando validações básicas (exemplo: verificação de nulos)
    test('deve ser lançado se algum campo estiver faltando no fromMap', () {
      expect(
        () => Listin.fromMap({
          'id': '4',
          // 'name' is missing
          'obs': 'Observação 4',
          'dateCreate': '2023-05-02T12:00:00Z',
          'dateUpdate': '2023-05-02T13:00:00Z',
        }),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
