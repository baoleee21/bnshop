import 'package:bnshop/consts/consts.dart';

Widget orderStatus({icon,color,title,showDone}){
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: redColor).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        children: [
          "$title".text.color(darkFontGrey).make(),
          showDone ? const Icon(
            Icons.done,
            color: redColor,
          ):Container(),
        ],
      ),
    ),
  );
}