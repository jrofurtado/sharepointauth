import 'dart:json' as json;
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:sharepointauth/authentication.dart';
import 'dart:async';

class Sharepointauth extends WebComponent {
@observable
  Authentication authentication;
// possible values of type: prod, qual, mock
@observable
  String type="mock";
@observable
  String app;
@observable
  int refreshtimeout=3600;
@observable
  String get endpoint{
    String endpoint;
    if(type=="mock")
      endpoint = "../mockauth.html";
    else if(type=="prod")
      endpoint = "http://intranet.eda.pt/Paginas/JSONAUTH.aspx";
    else
      endpoint = "http://qintranet.eda.pt/Paginas/JSONAUTH.aspx";
    endpoint+="?app=${app}";
    return endpoint;
  }
  
  void defaultImage(){
    query("#sharepointauth_profileImage").attributes["src"]="packages/sharepointauth/components/nophoto.png";
  }
  void reloadIframe(){
    Element iframe = query("#sharepointauth_iframe");
    if(iframe!=null){
      iframe.attributes["src"] += "";
    }
  }
  void created(){
    window.onMessage.listen((MessageEvent event) {
      Map data = json.parse(event.data);
      authentication = new Authentication(data["user"],data["name"],data["datetime"],data["key"], data["error"]);
    });
    window.onLoad.listen((event) {
      Duration duration = new Duration(seconds:refreshtimeout);
      new Timer.periodic(duration, (timer)=>reloadIframe());      
    });
  }
}
