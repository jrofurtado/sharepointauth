import 'package:web_ui/web_ui.dart';

@observable
class Authentication{
  String user;
  String name;
  String datetime;
  String key;
  String error;
  Authentication(this.user,this.name,this.datetime,this.key, this.error);
}