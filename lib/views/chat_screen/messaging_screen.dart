import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/services/firestore_services.dart';
import 'package:bnshop/widgets_common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class MessagingScreen extends StatelessWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot>snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return "No message yet!".text.color(darkFontGrey).makeCentered();
          }
          else{
            return Container();
          }
        },
      ),
    );
  }
}
