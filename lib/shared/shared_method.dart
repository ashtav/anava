part of 'shared.dart';

class Fn {
  static navigate(BuildContext context, Widget widget, {Function(dynamic value) then}){
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget)).then((value){
      if(then != null) then(value);
    });
  }
}