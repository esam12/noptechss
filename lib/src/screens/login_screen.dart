import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../app_localizations.dart';
import '../helpers/helpers.dart';
import '../helpers/utility.dart';
import '../models/user_model.dart';
import '../providers/api_provider.dart';
import '../widgets/login_top_part.dart';

class LoginScreen extends StatefulWidget {
  final bool fromAccount;

  const LoginScreen({Key? key, this.fromAccount = false}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiProvider _provider = ApiProvider();
  bool _saveDomain = false;
  bool _isLoading = false;
  bool _showUi = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _domainCtrl = TextEditingController();
  final _databaseCtrl = TextEditingController();
  final _userNameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  String? _domainError;
  final _reg = RegExp(
      r'(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]');
  @override
  void initState() {
    _setSaveDomain();
    super.initState();
  }

  void _setSaveDomain() async {
    if (widget.fromAccount) {
      setState(() {
        _showUi = true;
      });
      return;
    }
    var shared = await SharedPreferences.getInstance();
    var list = shared.getString(Helpers.savedDomainList);
    print("List item $list");
    if (list != null && list.isNotEmpty) {
      Navigator.of(context).pushReplacementNamed(Helpers.accountRoute);
    } else {
      setState(() {
        _showUi = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_showUi
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LoginTop(),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(
                        left: 12, right: 12, top: 10, bottom: 50),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, 15),
                              blurRadius: 15),
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, -10),
                              blurRadius: 10)
                        ]),
                    child: _buildForm(context),
                  ),
                  //Padding(padding: EdgeInsets.only(top: 50),)
                ],
              ),
            ),
    );
  }

  void _onLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Utility.getInstance().showNopDialog(
          context,
          AppLocalizations.of(context)!.noInternet,
          AppLocalizations.of(context)!.noInternetMessage);
      return;
    }
    if (_domainCtrl.text.contains("www.")) {
      _domainCtrl.text = _domainCtrl.text.replaceFirst("www.", "");
      print(_domainCtrl.text);
    }
    if (!_domainCtrl.text.startsWith("https://")) {
      _domainCtrl.text = "https://${_domainCtrl.text.trim()}";
    }

    UserModel user = UserModel(
      domain: _domainCtrl.text,
      dbName: _databaseCtrl.text,
      password: _passwordCtrl.text,
      saveDomain: _saveDomain,
      userName: _userNameCtrl.text,
    );
    setState(() {
      _isLoading = true;
    });

    var odooVersion = await _provider.connectToOdoo(user.domain!);

    //print("Response : ${response.response}");
    print("Response Version : ${odooVersion.toString()}");
    if (odooVersion == null) {
      Utility.getInstance().showNopDialog(
          context,
          AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.errorWentWrong);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    var odooUser = await _provider.authenticate(
        user.userName!, user.password!, user.dbName!);
    print(odooUser);
    if (odooUser != null) {
      print(odooUser);
      setState(() {
        _isLoading = false;
      });
      if (user.saveDomain!) {
        // await shared.setBool(Helpers.savedDomainStore, true);
        // await shared.setString(Helpers.savedDomainNamedStore, user.domain);
        // await shared.setString(Helpers.savedUserName, user.userName);
        // await shared.setString(Helpers.savedPassword, user.password);
        _wirteDomain(user);
      }

      Navigator.pushReplacementNamed(context, Helpers.systemViewRoute,
          arguments: user);
    } else {
      setState(() {
        _isLoading = false;
      });
      Utility.getInstance().showNopDialog(
          context,
          AppLocalizations.of(context)!.error,
          AppLocalizations.of(context)!.userNamePwdInvalid);
      return;
    }
  }

  Widget _buildForm(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _domainCtrl,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.domain,
                hintText: "noptechs.com",
                errorStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                // icon
                icon: Icon(
                  Icons.web,
                  color: Theme.of(context).primaryColor,
                  size: 26,
                ),
                errorText: _domainError,
              ),
              keyboardType: TextInputType.url,
              validator: (String? text) {
                text = text!.trim();
                if (text.isEmpty) {
                  return AppLocalizations.of(context)!.domainRequired;
                }
                if (!_reg.hasMatch(text)) {
                  return AppLocalizations.of(context)!.domainValid;
                }
                // if (!text.endsWith("noptechs.com")) {
                //   return AppLocalizations.of(context).onlyNoptechs;
                // }
                _domainCtrl.text = text;
                return null;
              },
            ),
            TextFormField(
              controller: _databaseCtrl,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.db,
                hintText: "database",
                errorStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                icon: Icon(
                  Icons.storage,
                  color: Theme.of(context).primaryColor,
                  size: 26,
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              validator: (String? text) {
                text = text!.trim();
                if (text.isEmpty) {
                  return AppLocalizations.of(context)!.databaseRequired;
                }

                _databaseCtrl.text = text;
                return null;
              },
            ),
            TextFormField(
              controller: _userNameCtrl,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.userName,
                hintText: "user@noptechs.com",
                errorStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).primaryColor,
                  size: 26,
                ),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (String? text) {
                if (text!.isEmpty) {
                  return AppLocalizations.of(context)!.userNameRequired;
                }
                return null;
              },
            ),
            TextFormField(
              controller: _passwordCtrl,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.password,
                icon: Icon(
                  Icons.lock,
                  color: Theme.of(context).primaryColor,
                  size: 26,
                ),
              ),
              obscureText: true,
              validator: (String? text) {
                if (text!.isEmpty) {
                  return AppLocalizations.of(context)!.passwordRequired;
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: SwitchListTile(
                value: _saveDomain,
                title: Text(AppLocalizations.of(context)!.saveDomain),
                onChanged: (bool value) {
                  setState(() {
                    _saveDomain = value;
                  });
                },
                activeColor: Theme.of(context).primaryColor,
              ),
            ),
            _buildLoginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    if (_isLoading) {
      return Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(top: 10.0),
        child: Container(
          alignment: Alignment.center,
          width: 140,
          height: 50,
          child: const CircularProgressIndicator(),
        ),
      );
    }
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(top: 10),
      child: InkWell(
        child: Container(
          alignment: Alignment.centerRight,
          width: 140,
          height: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: <Color>[
                Color(0xFF9F2C48),
                Color(0xFF6C0543),
              ],
            ),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C0543).withOpacity(.3),
                offset: const Offset(0.0, 8.0),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _onLogin(context);
              },
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: const TextStyle(
                    fontFamily: "Lora",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 1.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _wirteDomain(UserModel user) async {
    var shared = await SharedPreferences.getInstance();
    var dataStr = shared.getString(Helpers.savedDomainList);
    print(dataStr);
    String uJson = "";
    List<UserModel> users = [];
    if (dataStr != null && dataStr != "") {
      Iterable userIteralbe = json.decode(dataStr);
      print(userIteralbe.length);
      users = userIteralbe.map((u) => UserModel.fromJson(u)).toList();
      print(users.length);
    } else {
      users = [];
    }
    var index = -100;
    for (var uItem in users) {
      if (uItem.domain == user.domain && uItem.userName == user.userName) {
        index = users.indexOf(uItem);
      }
    }
    if (index != -100) users.removeAt(index);

    users.add(user);
    uJson = json.encode(users);
    print(users.length);
    await shared.setString(Helpers.savedDomainList, uJson);
  }
}
