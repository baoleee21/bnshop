import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/consts/lists.dart';
import 'package:bnshop/controller/auth_controller.dart';
import 'package:bnshop/controller/profile_controller.dart';
import 'package:bnshop/services/firestore_services.dart';
import 'package:bnshop/views/auth_screen/login_screen.dart';
import 'package:bnshop/views/wishlist_screen/wishlist_screen.dart';
import 'package:bnshop/views/chat_screen/messaging_screen.dart';
import 'package:bnshop/views/orders_screen/orders_screen.dart';
import 'package:bnshop/views/profile_screen/edit_profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:bnshop/widgets_common/bg_widget.dart';
import 'package:bnshop/views/profile_screen/components/details_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else {
                var data = snapshot.data!.docs[0];

                return SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Align(
                          alignment: Alignment.topRight,
                          child: const Icon(
                            Icons.edit,
                            color: whiteColor,
                          ),
                        ).onTap(() {
                          controller.nameController.text = data['name'];
                          Get.to(() => EditProfileScreen(data: data));
                        }),
                      ),

                      //user details section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            data['imgUrl'] == ''
                                ? Image.asset(imgProfile2,
                                        width: 80, fit: BoxFit.cover)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make()
                                : Image.network(data['imgUrl'],
                                        width: 80, fit: BoxFit.cover)
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make(),
                            10.widthBox,
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make(),
                                "${data['email']}".text.white.make()
                              ],
                            )),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                  color: whiteColor,
                                )),
                                onPressed: () async {
                                  await Get.put(AuthCotroller())
                                      .signoutMethod(context);
                                  Get.offAll(() => const LoginScreen());
                                },
                                child: logout.text
                                    .fontFamily(semibold)
                                    .white
                                    .make())
                          ],
                        ),
                      ),

                      20.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsCard(
                              count: "${data['cart_count']}",
                              title: "in your cart",
                              width: context.screenWidth / 3.4),
                          detailsCard(
                              count: "${data['wishlist_count']}",
                              title: "in your wishlist",
                              width: context.screenWidth / 3.4),
                          detailsCard(
                              count: "${data['order_count']}",
                              title: "in your order",
                              width: context.screenWidth / 3.4),
                        ],
                      ),

                      //  buttons section
                      ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(color: lightGrey);
                        },
                        itemCount: profileButtonList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => OrdersScreen());
                                  break;
                                case 1:
                                  Get.to(() => WishlistScreen());
                                  break;
                                case 2:
                                  Get.to(() => MessagingScreen());
                                  break;
                              }
                            },
                            leading: Image.asset(
                              profileButtonsIcon[index],
                              width: 22,
                            ),
                            title: "${profileButtonList[index]}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                          );
                        },
                      )
                          .box
                          .white
                          .rounded
                          .margin(const EdgeInsets.all(12))
                          .padding(EdgeInsets.symmetric(horizontal: 16))
                          .shadowSm
                          .make()
                          .box
                          .color(redColor)
                          .make(),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
