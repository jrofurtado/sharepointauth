import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:sharepointauth/authentication.dart';

@observable
Authentication authentication;

void waitForAuthentication(){
  authentication.waitForAuthentication();
}

void main() {
  authentication = new Authentication(30, 5);
  // Enable this to use Shadow DOM in the browser.
  //useShadowDom = true;
}
