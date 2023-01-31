import 'dart:io';

import 'package:dio/dio.dart';

import '../models/noptech_http_reponse.dart';
import '../models/server_info.dart';
import 'Odoo/authenticate_callback.dart';
import 'Odoo/odoo_client.dart';
import 'Odoo/odoo_version.dart';

class ApiProvider {
  final Dio _client = Dio();
  OdooClient? client;

  Future<OdooVersion?> connectToOdoo(String domain) async {
    try {
      print(domain);
      client = OdooClient(domain);
      client?.debugRPC(true);
      final version = await client?.connect();
      return version;
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<dynamic>> getDatabases() {
    return client!.getDatabases();
  }

  Future<OdooUser?> authenticate(
      String username, String password, String db) async {
    try {
      AuthenticateCallback auth =
          await client!.authenticate(username, password, db);
      //print("Auth Object ${auth.getError()}");
      if (auth.isSuccess) {
        return auth.getUser();
      }
      return null;
    } on Error catch (e) {
      print(e);
      print("Exception 1");
      return null;
    } on Exception catch (ex) {
      print(ex);
      print("Exception 2");
      return null;
    }
  }

  Future<Null> signup(String domain, Map<String, String> user) async {
    try {
      //client.debugRPC(true);
      //var result = await client.create('res.users',user);
      var result = await client!.callKW('res.users', "create", [user]);
      print("sgnup result $result");

      if (!result.hasError()) {
        print("sgnup newId $result");
      } else {
        print("sgnup get error ${result.getError()}");
      }
      return null;
    } on Error catch (e) {
      print(e);
      print("Exception 1");
      return null;
    } on Exception catch (ex) {
      print(ex.toString());
      print("Exception 2");
      return null;
    }
  }

  Future<NoptechHttpResponse<ServerInfo>> getServerInfo(String domain) async {
    try {
      var response = await _client.get(domain);
      if (response.statusCode == HttpStatus.ok) {
        var header = response.redirects
            .firstWhere((e) => e.location.path.contains("web/login"));
        if (header != null) {
          var info = ServerInfo(header.location.host, header.location.port,
              header.location.queryParameters["db"]!);
          return NoptechHttpResponse<ServerInfo>(
            status: NoptechHttpStatus.Ok,
            message: "XXXXXXX",
            response: info,
          );
        }
      }
      return NoptechHttpResponse(
        status: NoptechHttpStatus.Error,
        message: "Error While Connecting the server please contact the admin.",
        response: ServerInfo("XX", 00, "XX"),
      );
    } on DioError {
      return NoptechHttpResponse(
        status: NoptechHttpStatus.Error,
        message: "Error while login please try again later.",
        response: ServerInfo("XX", 00, "XX"),
      );
    } on Exception catch (e) {
      print("Dio Error $e");
      return NoptechHttpResponse(
        status: NoptechHttpStatus.Error,
        message: "Error while login please try again later.",
        response: ServerInfo("XX", 00, "XX"),
      );
    }
  }
}
