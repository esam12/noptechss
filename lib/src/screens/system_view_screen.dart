import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../app_localizations.dart';
import '../helpers/helpers.dart';
import '../models/user_model.dart';

class SystemViewScreen extends StatefulWidget {
  final UserModel user;
  const SystemViewScreen({super.key, required this.user, this.cookieManager});
  final WebViewCookieManager? cookieManager;

  @override
  State<SystemViewScreen> createState() => _SystemViewScreenState();
}

class _SystemViewScreenState extends State<SystemViewScreen> {
  late final WebViewController _controller;
  var isLoading = false;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.enableZoom(false);
    //controller.setBackgroundColor(const Color(0x00000000));
    controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          debugPrint('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (String url) {
          debugPrint('Page started loading: $url');
        },
        onPageFinished: (String url) {
          debugPrint('Page finished loading: $url');
          if (url.contains("${widget.user.domain}/web/login")) {
            controller.runJavaScript("""
            console.log("Current Url "+window.location.pathname);
            if(window !== null && document !== null){
              if(window.location.pathname.indexOf("web/login") !== -1){
                console.log("User is On Login");
                //Create overly on the top of the current element.
                //document.body.style.background = "#000";
                //var para = document.createElement("div");
                //para.style.cssText = "position: fixed;width: 100%;height: 100%;top: 0;left: 0;right: 0;bottom: 0;background-color: rgba(108, 5, 67,1);z-index: 10000;cursor: pointer;";
                if(document !== null && document.body !== null){
                //document.body.appendChild(para);

				var login = document.getElementById("login");
                if(login != null){
                    login.value = "${widget.user.userName}";
                    console.log("UserName set");

					var password = document.getElementById("password");

					if(password !== null){
						password.value = "${widget.user.password}";
						console.log("Password set");

						var x = document.getElementsByClassName("oe_login_form")[0];
						if(x != null){
						  console.log("Submitting the form");
						  x.submit();
						}else{
						  console.log("NO Form Found");
						  window.location.reload();
						}
					}else{
					console.log("Password is null");
					}
                }else{
                  console.log("UserName is null");
                }
              }
              }else{
                console.log("User is not on login");
              }
            }
          """);
          } else if (url.contains("${widget.user.domain}/ar/web/login")) {
            controller.runJavaScript("""
            console.log("Current Url "+window.location.pathname);
            if(window !== null && document !== null){
              if(window.location.pathname.indexOf("web/login") !== -1){
                console.log("User is On Login");
                //Create overly on the top of the current element.
                //document.body.style.background = "#000";
                //var para = document.createElement("div");
                //para.style.cssText = "position: fixed;width: 100%;height: 100%;top: 0;left: 0;right: 0;bottom: 0;background-color: rgba(108, 5, 67,1);z-index: 10000;cursor: pointer;";
                if(document !== null && document.body !== null){
                //document.body.appendChild(para);

				var login = document.getElementById("login");
                if(login != null){
                    login.value = "${widget.user.userName}";
                    console.log("UserName set");

					var password = document.getElementById("password");

					if(password !== null){
						password.value = "${widget.user.password}";
						console.log("Password set");

						var x = document.getElementsByClassName("oe_login_form")[0];
						if(x != null){
						  console.log("Submitting the form");
						  x.submit();
						}else{
						  console.log("NO Form Found");
						  window.location.reload();
						}
					}else{
					console.log("Password is null");
					}
                }else{
                  console.log("UserName is null");
                }
              }
              }else{
                console.log("User is not on login");
              }
            }
          """);
          }
          setState(() {
            isLoading = true;
          });
        },
        onWebResourceError: (WebResourceError error) {
          debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
        },
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('js://webview')) {
            // _showErrorToast(context, request.url.split('js://webview?arg=')[1]);
            return NavigationDecision.prevent;
          }
          print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
      ),
    );
    controller.addJavaScriptChannel(
      'Toaster',
      onMessageReceived: (JavaScriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
    controller.loadRequest(Uri.parse("${widget.user.domain}"));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.noptechsErp),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          NavigationControls(webViewController: _controller),
          SampleMenu(webViewController: _controller),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (!isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

enum MenuOptions {
  logout,
  clearCookies,
  addToCache,
  clearCache,
  setCookie,
}

class SampleMenu extends StatelessWidget {
  SampleMenu({
    super.key,
    required this.webViewController,
  });

  final WebViewController webViewController;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOptions>(
      key: const ValueKey<String>('ShowPopupMenu'),
      onSelected: (MenuOptions value) {
        switch (value) {
          case MenuOptions.logout:
            _onLogout(context);
            break;

          case MenuOptions.clearCookies:
            _onClearCookies(context);
            break;
          case MenuOptions.addToCache:
            _onAddToCache(context);
            break;

          case MenuOptions.clearCache:
            _onClearCache(context);
            break;

          case MenuOptions.setCookie:
            _onSetCookie();
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.logout,
          child: Text('Logout'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.clearCookies,
          child: Text('Clear cookies'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.addToCache,
          child: Text('Add to cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.clearCache,
          child: Text('Clear cache'),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.setCookie,
          child: Text('Set cookie'),
        ),
      ],
    );
  }

  void _onLogout(BuildContext context) async {
    Navigator.pushReplacementNamed(context, Helpers.loginRoute);
  }

  Future<void> _onAddToCache(BuildContext context) async {
    await webViewController.runJavaScript(
      'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";',
    );
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Added a test entry to cache.'),
    ));
  }

  Future<void> _onClearCache(BuildContext context) async {
    await webViewController.clearCache();
    await webViewController.clearLocalStorage();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Cache cleared.'),
    ));
  }

  Future<void> _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> _onSetCookie() async {
    await cookieManager.setCookie(
      const WebViewCookie(
        name: 'foo',
        value: 'bar',
        domain: 'httpbin.org',
        path: '/anything',
      ),
    );
    await webViewController.loadRequest(Uri.parse(
      'https://httpbin.org/anything',
    ));
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls({super.key, required this.webViewController});

  final WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () async {
            if (await webViewController.canGoBack()) {
              await webViewController.goBack();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No back history item')),
              );
              return;
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () async {
            if (await webViewController.canGoForward()) {
              await webViewController.goForward();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No forward history item')),
              );
              return;
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.replay),
          onPressed: () => webViewController.reload(),
        ),
      ],
    );
  }
}
