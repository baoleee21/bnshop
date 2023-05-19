import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/services/firestore_services.dart';
import 'package:bnshop/widgets_common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No wishlist yet!".text.color(darkFontGrey).makeCentered();
          } else {
            var Data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemCount: Data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.network(
                              '${Data[index]['p_img'][0]}',
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            title: "${Data[index]['p_name']}"
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                            subtitle: "${Data[index]['p_price']}"
                                .numCurrency
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                            trailing: Icon(
                              Icons.favorite,
                              color: redColor,
                            ).onTap(()async {
                              await firestore.collection(productCollection).doc(Data[index].id).set(
                                {
                                  'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
                                },SetOptions(merge: true)
                              );
                            }),
                          );
                        }))
              ],
            );
          }
        },
      ),
    );
  }
}
