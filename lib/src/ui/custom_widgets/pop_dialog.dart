import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Popup {
  static show(
    BuildContext context,
  ) {
    var formState = GlobalKey<FormState>();
    var controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Icon(
              Icons.error_outline,
              //  Icons.close_rounded,
              color: Colors.red,
              size: 30,
            ),
            content: Material(
              color: Colors.transparent,
              child: Form(
                  key: formState,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: controller,
                        decoration:
                            InputDecoration(labelText: "input your IP address"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 80,
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () {
                              if (formState.currentState.validate()) {
                                Navigator.pop(context);
                              }
                            },
                            child: Text("Close")),
                      )
                    ],
                  )),
            ),
          );
        });
  }
}
