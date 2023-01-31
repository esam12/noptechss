import 'package:flutter/material.dart';

import '../app_localizations.dart';

class Utility {
  static Utility? _utility;
  static Utility getInstance() {
    _utility ??= Utility();
    return _utility!;
  }

  void showNopDialog(BuildContext context, String title, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext alert) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Icon(
                Icons.error,
                size: 32,
                color: Colors.red.shade900,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              Text(title)
            ],
          ),
          content: SingleChildScrollView(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          actions: <Widget>[
            FloatingActionButton(
              child: Text(
                AppLocalizations.of(context)!.ok,
                style: const TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(alert).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
