import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:istore/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('integration-test', () {
    testWidgets('home-screen', (WidgetTester tester) async {
      await setUp(tester);
      expect(find.text('Category'), findsOneWidget);
      expect(find.text('เสื้อผ้า'), findsOneWidget);
      expect(find.text('ผลไม้'), findsOneWidget);
      expect(find.text('อุปกรณ์ IT'), findsOneWidget);
      expect(find.text('แก้ว'), findsOneWidget);
    });

    testWidgets('product-list', (WidgetTester tester) async {
      await setUp(tester);
      await goToFirstObj(tester);
      expect(find.text("เสื้อแขนสั้น"), findsOneWidget);
      expect(find.text("100"), findsOneWidget);
    });

    testWidgets('product-detail', (WidgetTester tester) async {
      await setUp(tester);
      await goToFirstObj(tester);
      await goToFirstObj(tester);
      expect(find.text("เสื้อแขนสั้น"), findsOneWidget);
      expect(find.text("ราคา 100"), findsOneWidget);
      expect(find.text("รายละเอียด"), findsOneWidget);
      expect(find.byKey(Key("cart_btn")), findsOneWidget);
    });

    testWidgets('cart', (WidgetTester tester) async {
      await setUp(tester);
      await goToFirstObj(tester);
      await goToFirstObj(tester);
      var cartButton = find.byKey(Key("cart_btn"));
      await tester.tap(cartButton);
      await tester.pumpAndSettle();

      var addBtn = find.byKey(Key("add_btn"));
      var removeBtn = find.byKey(Key("remove_btn"));
      var itemCountFinder = find.byKey(Key("item_count_txt"));
      var priceCountFinder = find.byKey(Key("price_txt"));
      var totalCountFinder = find.byKey(Key("total_txt"));

      //landing cart page
      int price = 100;
      int mockItemCount = 1;
      expectValueText(
          (itemCountFinder.evaluate().single.widget as Text),
          mockItemCount,
          (priceCountFinder.evaluate().single.widget as Text),
          price,
          (totalCountFinder.evaluate().single.widget as Text));

      //add case
      for (int i = 0; i < 5; i++) {
        await tester.tap(addBtn);
        await tester.pumpAndSettle();
        mockItemCount = mockItemCount + 1;
        expectValueText(
            (itemCountFinder.evaluate().single.widget as Text),
            mockItemCount,
            (priceCountFinder.evaluate().single.widget as Text),
            price,
            (totalCountFinder.evaluate().single.widget as Text));
      }

      //remove one-time case
      await tester.tap(removeBtn);
      await tester.pumpAndSettle();
      mockItemCount = mockItemCount - 1;
      expectValueText(
          (itemCountFinder.evaluate().single.widget as Text),
          mockItemCount,
          (priceCountFinder.evaluate().single.widget as Text),
          price,
          (totalCountFinder.evaluate().single.widget as Text));

      //add multiple-time case
      for (int i = 0; i < 4; i++) {
        await tester.tap(removeBtn);
        await tester.pumpAndSettle();
        mockItemCount = mockItemCount - 1;
        expectValueText(
            (itemCountFinder.evaluate().single.widget as Text),
            mockItemCount,
            (priceCountFinder.evaluate().single.widget as Text),
            price,
            (totalCountFinder.evaluate().single.widget as Text));
      }

      //remove all-item case
      await tester.tap(removeBtn);
      await tester.pumpAndSettle();
      expect(addBtn, findsNothing);
      expect(removeBtn, findsNothing);
      expect(itemCountFinder, findsNothing);
      expect(priceCountFinder, findsNothing);
      expect(find.text("ราคารวม 0"), findsOneWidget);
    });
  });
}

void expectValueText(Text itemCount, int mockItemCount, Text priceCount,
    int price, Text totalCount) {
  expect(itemCount.data, "${mockItemCount}");
  expect(
      priceCount.data, "${mockItemCount}x${price} = ${price * mockItemCount}");
  expect(totalCount.data, "ราคารวม ${price * mockItemCount}");
}

Future<void> goToFirstObj(WidgetTester tester) async {
  var firstObj = find.byKey(Key("1"));
  await tester.tap(firstObj);
  await tester.pumpAndSettle();
}

Future<void> setUp(WidgetTester tester) async {
  app.main();
  await tester.pumpAndSettle();
  await Future.delayed(Duration(seconds: 10));
  await tester.pumpAndSettle();
}
