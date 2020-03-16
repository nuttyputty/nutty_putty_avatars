import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'dart:io' show Platform;

Future<void> initPlatformState(iosList, androidList) async {
  await FlutterInappPurchase.instance.initConnection;

  await FlutterInappPurchase.instance.platformVersion;

  print(iosList);
  print(androidList);

  FlutterInappPurchase.purchaseUpdated.listen((productItem) async {
    if (Platform.isAndroid) {
      await FlutterInappPurchase.instance.acknowledgePurchaseAndroid(
        productItem.purchaseToken,
      );
      print(productItem);
    } else if (Platform.isIOS) {
      await FlutterInappPurchase.instance.finishTransactionIOS(
        productItem.purchaseToken,
      );
    }

    _getProduct(iosList, androidList);
    _getPurchases(false);
  });

  _getProduct(iosList, androidList);
  _getPurchases(false);
}

Future _getProduct(ios, android) async {
  List<IAPItem> items = await FlutterInappPurchase.instance
      .getProducts(Platform.isIOS ? ios : android);

  return items;
}

Future _getPurchases(restore) async {
  List<PurchasedItem> items =
      await FlutterInappPurchase.instance.getAvailablePurchases();

  return items;
}

hasPurchased(String productID, purchasedProduct) {
  return purchasedProduct.firstWhere(
      (purchase) => purchase.productId == productID,
      orElse: () => null);
}

void requestPurchase() {
  FlutterInappPurchase.instance
      .requestPurchase('com.nuttyputty.partymafia.rogue')
      .whenComplete(() {
    // _getProduct(iosList, androidList);
    // _getPurchases(false);
  });
}
