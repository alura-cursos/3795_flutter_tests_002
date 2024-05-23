import 'package:flutter/material.dart';
import 'package:flutter_listin/products/model/product.dart';
import 'package:flutter_listin/products/widgets/product_list_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("As informações básicas devem ser mostradas",
      (widgetTester) async {
    Product product = Product(
      id: "ID001",
      name: "Detergente",
      obs: "",
      category: "",
      isKilograms: false,
      isPurchased: false,
      amount: 2,
      price: 3.5,
    );

    checkboxClick({
      required Product product,
      required String listinId,
    }) {
      product.isPurchased = !product.isPurchased;
    }

    await widgetTester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            ProductListItem(
              listinId: "LISTIN_ID",
              produto: product,
              showModal: () {},
              checkboxClick: checkboxClick,
              trailClick: () {},
            ),
          ],
        ),
      ),
    ));

    Finder findCheckbox = find.byType(Checkbox);
    Finder findDelete = find.widgetWithIcon(IconButton, Icons.delete);
    Finder findTitle =
        find.text("${product.name} (x${product.amount!.toInt()})");
    Finder findSubtitle = find.byKey(const Key("subtitle"));

    expect(findCheckbox, findsOne);
    expect(findDelete, findsOne);
    expect(findTitle, findsOne);
    expect(findSubtitle, findsOne);

    Text subtitle = widgetTester.widget<Text>(findSubtitle);
    expect(subtitle.data, equals("R\$ ${product.price}"));

    await widgetTester.tap(findCheckbox);
    await widgetTester.pumpAndSettle();

    expect(
      widgetTester.widget<Checkbox>(findCheckbox).value,
      equals(product.isPurchased),
    );
  });
}
