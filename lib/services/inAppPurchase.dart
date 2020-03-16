import 'dart:async';

import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'dart:io' show Platform;

Future<void> initPlatformState(iosList, androidList, cb) async {
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
    cb();
    _getProduct(iosList, androidList);
    getPurchases(false);
  });

  StreamSubscription _purchaseErrorSubscription =
      FlutterInappPurchase.purchaseError.listen((purchaseError) {
    print('ERRORRR');
  });

  _getProduct(iosList, androidList);
  getPurchases(false);
}

Future _getProduct(ios, android) async {
  List<IAPItem> items = await FlutterInappPurchase.instance
      .getProducts(Platform.isIOS ? ios : android);
  print('[ITEMS] $items');
  return items;
}

Future getPurchases(restore) async {
  List<PurchasedItem> items =
      await FlutterInappPurchase.instance.getAvailablePurchases();
  print('[ITEMS PURCHASED] $items');
  return items;
}

hasPurchased(String productID, purchasedProduct) {
  return purchasedProduct.firstWhere(
      (purchase) => purchase.productId == productID,
      orElse: () => null);
}

void requestPurchase() {
  print('tyt');
  FlutterInappPurchase.instance
      .requestPurchase('com.nuttyputty.partymafia.avatars');
}
