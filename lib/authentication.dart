import 'package:web_ui/web_ui.dart';
import 'dart:async';

@observable
class Authentication{
  String user;
  String name;
  String datetime;
  String key;
  String error;
  Completer completer = new Completer();
  
  Authentication();
  
  void waitForAuthentication(){
    if(!completer.isCompleted)
      Future.wait([completer.future]);
  }
}