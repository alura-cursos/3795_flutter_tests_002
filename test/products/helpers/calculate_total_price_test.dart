import 'dart:math';

import 'package:flutter_listin/products/helpers/calculate_total_price.dart';
import 'package:flutter_listin/products/model/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    "Entradas simples:",
    () {
      test("Uma lista de produtos vazia, deve dar um total de zero.", () {
        List<Product> listProducts = [];
        double result = calculateTotalPriceFromListProduct(listProducts);
        expect(result, 0);
      });

      test(
          "Em uma lista com apenas um elemento, "
          "a função deve devolver um total que corresponda ao "
          "preço unitário do produto multiplicado pela sua quantidade.", () {
        List<Product> listProducts = [];

        Product product = Product(
          id: "ID001",
          name: "Desinfetante",
          obs: "",
          category: "",
          isKilograms: false,
          isPurchased: true,
          amount: Random().nextInt(10).toDouble(),
          price: Random().nextDouble() * 10,
        );
        listProducts.add(product);

        double result = calculateTotalPriceFromListProduct(listProducts);

        expect(
          result,
          product.amount! * product.price!,
          skip: listProducts.isEmpty,
          reason: "Espera-se que a função leve em consideração não "
              "apenas o valor mas a quantidade do item.",
        );
      });

      test(
        "A função não deve retornar números negativos",
        () {
          List<Product> listProducts = [
            Product(
              id: "ID001",
              name: "Feijão",
              obs: "",
              category: "",
              isKilograms: false,
              isPurchased: true,
              amount: Random().nextInt(10).toDouble(),
              price: Random().nextDouble() * 10,
            ),
          ];

          double result = calculateTotalPriceFromListProduct(listProducts);

          expect(result, isNonNegative);
        },
        retry: 1000000,
      );
    },
  );
  group(
    "Casos excepcionais:",
    () {
      test(
        "A função deve levantar exceção caso haja um produto que não "
        "esteja no carrinho.",
        () {
          List<Product> listProducts = [
            Product(
              id: "ID001",
              name: "Cenoura",
              obs: "",
              category: "",
              isKilograms: false,
              isPurchased: false,
              amount: Random().nextInt(10).toDouble(),
              price: Random().nextDouble() * 10,
            ),
            Product(
              id: "ID002",
              name: "Desinfetante",
              obs: "",
              category: "",
              isKilograms: false,
              isPurchased: true,
              amount: Random().nextInt(10).toDouble(),
              price: Random().nextDouble() * 10,
            ),
            Product(
              id: "ID003",
              name: "Açúcar",
              obs: "",
              category: "",
              isKilograms: false,
              isPurchased: false,
              amount: Random().nextInt(10).toDouble(),
              price: Random().nextDouble() * 10,
            )
          ];

          expect(
            () => calculateTotalPriceFromListProduct(listProducts),
            throwsA(
              isA<ProductNotPurchasedException>(),
            ),
          );
        },
      );
    },
  );
}
