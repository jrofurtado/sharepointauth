library authentication;

import 'package:web_ui/web_ui.dart';
import 'dart:async';
import 'dart:html';

@observable
class Authentication{
  int refreshtimeout=3600;
  int tokentimeout=4600;
  String user;
  String name;
  String datetime;
  String key;
  String error;
  bool get _expired{
    if(datetime==null)
      return false;
    else{
      DateTime date = new DateTime(int.parse(datetime.substring(0, 4)),int.parse(datetime.substring(5, 7)),int.parse(datetime.substring(8, 10)),int.parse(datetime.substring(11, 13)),int.parse(datetime.substring(14, 16)),int.parse(datetime.substring(17, 19)));
      date = date.add(new Duration(seconds:tokentimeout));
      DateTime now = new DateTime.now();
      if(date.isBefore(now)){
        print("Authentication token expired on ${date}. Now is ${now}");
        return true;
      }else
        return false;
    }
  }
  Completer completer = new Completer();
  
  Authentication([refreshtimeout, tokentimeout]){
    this.refreshtimeout = refreshtimeout;
    this.tokentimeout = tokentimeout;
  }
  
  Future waitForAuthentication(){
    if(_expired){
      completer = new Completer();
      reloadIframe();
    }
    return completer.future;
  }
  
  void reloadIframe(){
    Element iframe = query("#sharepointauth_iframe");
    if(iframe!=null){
      iframe.attributes["src"] += "";
      print("reloadIframe() em ${new DateTime.now().toString()}");
    }
  }
}