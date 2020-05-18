import 'package:flutter/material.dart';
import 'package:nutty_putty_avatars/services/hexToColor.dart';
import 'package:nutty_putty_avatars/services/inAppPurchase.dart';
import 'package:nutty_putty_avatars/styles/index.dart';

Widget wrapper(title, text, isImage) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(5),
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   stops: [0.45, 1],
        //   colors: gradient,
        // ),
        color: Colors.white,
        boxShadow: shadow),
    child: Column(
      children: <Widget>[
        Text(title,
            style: TextStyle(
                color: hexToColor('#3C4F73'),
                fontSize: 18,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        isImage
            ? Padding(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Image(
                  image: AssetImage('assets/images/avatars.png',
                      package: 'nutty_putty_avatars'),
                ))
            : Container(),
        Text(
          text,
          style: TextStyle(
            color: hexToColor('#8D9CB3').withOpacity(0.7),
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

void showPopUp(context, loader, toogleLoader, id) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
            elevation: 0.0,
            shape: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15)),
            contentPadding: EdgeInsets.all(15),
            content: UpgradePopup(
                loader: loader,
                changeLoader: (data) {
                  toogleLoader(data);
                },
                id: id));
      });
}

class UpgradePopup extends StatefulWidget {
  UpgradePopup({this.loader, this.changeLoader, this.id, this.closePopup});
  var loader;
  final changeLoader;
  final closePopup;
  final id;
  UpgradePopupState createState() => UpgradePopupState();
}

class UpgradePopupState extends State<UpgradePopup> {
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        wrapper('Unlock Avatar+ \$9.99',
            'Combine more items and\nget new looks', true),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 20),
          child: wrapper(
              'Express yourself!', 'Complete your image here and now!', false),
        ),
        wrapper('Be unique!', 'Friends will instantly recognize you', false),
        Padding(
            padding: EdgeInsets.only(top: 20),
            child: !widget.loader
                ? SizedBox(
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          widget.loader = true;
                        });
                        widget.changeLoader(true);

                        requestPurchase(widget.id);
                      },
                      padding: EdgeInsets.only(
                          left: 30, top: 8, right: 30, bottom: 8),
                      color: hexToColor('#80B5EB'),
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  )
                : Container(
                    width: 142,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: hexToColor('#80B5EB'),
                        borderRadius: BorderRadius.circular(5)),
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: new CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            hexToColor('#ffffff')),
                      ),
                    ),
                  )),
      ],
    );
  }
}
