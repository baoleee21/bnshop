import 'package:bnshop/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bnshop/consts/consts.dart';
import 'package:intl/intl.dart' as intl;
Widget senderBubble(DocumentSnapshot data){
  var t = data['creat_on'] ==null ? DateTime.now() : data['creat_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
      textDirection: data['uid']== currentUser!.uid ? TextDirection.rtl:TextDirection.ltr,
      child:  Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8.0),
        decoration: BoxDecoration(
            color:  data['uid'] == currentUser!.uid ? redColor :darkFontGrey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "${data['msg']}".text.white.size(16).make(),
            10.heightBox,
            time.text.color(whiteColor.withOpacity(0.5)).make(),
          ],
        ),
      ),
  );
}