import 'dart:json' as json;
import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'authentication.dart';

class Sharepointauth extends WebComponent {
@observable
  Authentication authentication;
// possible values of type: prod, qual, mock
@observable
  String type="mock";
@observable
  String app;
@observable
  int refreshTimeout;
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
    query("#profileImage").attributes["src"]="../nophoto.png";
  }
  void created(){
    window.onMessage.listen((MessageEvent event) {
      Map data = json.parse(event.data);
      authentication = new Authentication(data["user"],data["datetime"],data["key"], data["error"]);
    });
  }
}
