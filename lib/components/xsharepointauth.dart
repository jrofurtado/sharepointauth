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
    if(authentication!=null)
      authentication.reloadIframe();
  }
  void created(){
    window.onMessage.listen((MessageEvent event) {
      Map data = json.parse(event.data);
      if(authentication==null)
        authentication=new Authentication();
      authentication.user=data["user"];
      authentication.name=data["name"];
      authentication.datetime=data["datetime"];
      authentication.key=data["key"];
      authentication.error=data["error"];
      print("novo token autenticação recebido em ${new DateTime.now().toString()} com o seguinte timestamp ${authentication.datetime}");
      if(!authentication.completer.isCompleted)
        authentication.completer.complete(null);
    });
    window.onLoad.listen((event) {
      Duration duration = new Duration(seconds:authentication.refreshtimeout);
      new Timer.periodic(duration, (timer)=>reloadIframe());
    });
  }
}
