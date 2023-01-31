import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_localizations.dart';
import '../helpers/helpers.dart';
import '../models/user_model.dart';
import '../widgets/account_top_part.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({Key? key}) : super(key: key);

  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const AccountTop(),
            Container(
              height: 400.0,
              //color: Colors.red,
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
              child: _buildListView(),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(Helpers.loginRoute, arguments: true);
              },
              child: Container(
                //color: Colors.green,
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(right: 10, top: 10),
                padding: const EdgeInsets.all(10),
                child: Text(
                  AppLocalizations.of(context)!.backToLogin,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListView() {
    print("Build list view");
    return FutureBuilder(
      future: _getSavedData(),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> data) {
        if (!data.hasData) {
          return const CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: data.data!.length,
          itemBuilder: (BuildContext contexti, int index) {
            var item = data.data![index];
            return Card(
              margin: const EdgeInsets.all(5),
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 35.0,
                  backgroundImage: AssetImage('assets/images/logo.png'),
                  backgroundColor: Colors.white,
                ),
                title: Text(item.domain!),
                contentPadding: const EdgeInsets.all(10),
                subtitle: Text(item.userName!),
                trailing: GestureDetector(
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onTap: () async {
                    await _updateSavedData(data.data!, item);
                    setState(() {});
                  },
                ),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, Helpers.systemViewRoute,
                      arguments: item);
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<List<UserModel>> _getSavedData() async {
    List<UserModel> users = [];
    try {
      var shared = await SharedPreferences.getInstance();
      var dataStr = shared.getString(Helpers.savedDomainList);
      if (dataStr != null && dataStr != "") {
        Iterable userIteralbe = json.decode(dataStr);
        users = userIteralbe.map((u) => UserModel.fromJson(u)).toList();
      }
    } on Exception {
    } on Error {}
    return users;
  }

  Future _updateSavedData(List<UserModel> data, UserModel item) async {
    var shared = await SharedPreferences.getInstance();
    var index = -100;
    for (var uItem in data) {
      if (uItem.domain == item.domain && uItem.userName == item.userName) {
        index = data.indexOf(uItem);
      }
    }
    if (index != -100) data.removeAt(index);
    if (data.length == 0) {
      await shared.remove(Helpers.savedDomainList);
    } else {
      String uJson = json.encode(data);
      await shared.setString(Helpers.savedDomainList, uJson);
    }
  }
}
