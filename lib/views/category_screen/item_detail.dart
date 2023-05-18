import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/consts/lists.dart';
import 'package:bnshop/controller/product_controller.dart';
import 'package:bnshop/views/chat_screen/chat_screen.dart';
import 'package:bnshop/widgets_common/our_button.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key, required this.title, this.data})
      : super(key: key);

  //welcome to episode
  //here we are going to continue building our UI
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(onWillPop:()async{
      controller.resetValues();
      return true;
    },
      child: Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          controller.resetValues();
          Get.back();
        },icon:const Icon(Icons.arrow_back)),
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              )),
          Obx(() => IconButton(
              onPressed: () {
                if(controller.isFav.value){
                  controller.removeFromWishlist(data.id,context);
                }else{
                  controller.addToWishlist(data.id,context);
                }
              },
              icon:  Icon(
                Icons.favorite_outlined,
                color: controller.isFav.value ? redColor : darkFontGrey,
              )))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //  swipper section
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          aspectRatio: 16 / 9,
                          itemCount: data['p_img'].length,
                          viewportFraction: 1.0,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data["p_img"][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            );
                          }),
                      10.heightBox,
                      title!.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      //  rating
                      VxRating(
                        isSelectable: false,
                        value: double.parse(data['p_rating']),
                        onRatingUpdate: (value) {},
                        maxRating: 5,
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        count: 5,
                        size: 25,
                      ),
                      10.heightBox,
                      "${data['p_price']}"
                          .numCurrency
                          .text
                          .fontFamily(bold)
                          .color(redColor)
                          .size(18)
                          .make(),

                      10.heightBox,
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Seller".text.white.fontFamily(semibold).make(),
                                  5.heightBox,
                                  "${data['p_seller']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .size(16)
                                      .make(),
                                ],
                              )),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.message_rounded,
                              color: darkFontGrey,
                            ),
                          ).onTap(() {
                            Get.to(
                                    ()=>const ChatScreen(),
                              arguments: [data['p_seller'],data['vendor_id']],
                            );
                          })
                        ],
                      )
                          .box
                          .height(60)
                          .padding(const EdgeInsets.symmetric(horizontal: 16))
                          .color(textfieldGrey)
                          .make(),

                      //  Color section
                      20.heightBox,
                      Obx(
                            () => Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child:
                                  "Color : ".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: List.generate(
                                      data['p_colors'].length,
                                          (index) => Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          VxBox()
                                              .size(40, 40)
                                              .roundedFull
                                              .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                              .margin(
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4))
                                              .make()
                                              .onTap(() {
                                            controller.chageColorIndex(index);
                                          }),
                                          Visibility(
                                            visible: index ==
                                                controller.colorIndex.value,
                                            child: const Icon(Icons.done,
                                                color: Colors.white),
                                          ),
                                        ],
                                      )),
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            //quanlity
                            Row(
                              children: [
                                SizedBox(

                                  width: 100,
                                  child: "Quanlity : "
                                      .text
                                      .color(textfieldGrey)
                                      .make(),
                                ),
                                Obx(
                                      () => Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decreaseQuality();
                                            controller.caculatorTotalPrice(int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.remove)),
                                      controller.quanlity.value.text
                                          .size(16)
                                          .color(darkFontGrey)
                                          .fontFamily(bold)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.increaseQuanlity(int.parse(data['p_quanlity']));
                                            controller.caculatorTotalPrice(int.parse(data['p_price']));
                                          },
                                          icon: const Icon(Icons.add)),
                                      10.widthBox,
                                      "(${data['p_quanlity']} available)"
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                    ],
                                  ),
                                )
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                            Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: "Total: ".text.color(textfieldGrey).make(),
                                ),
                                Row(
                                  children: [
                                    "${controller.totalPrice.value}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .size(16)
                                        .fontFamily(bold)
                                        .make(),
                                  ],
                                ),
                              ],
                            ).box.padding(const EdgeInsets.all(8)).make(),
                          ],
                        ).box.white.shadowSm.make(),
                      ),

                      //  description section
                      10.heightBox,
                      "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                      10.heightBox,
                      "${data['p_desc']}".text.color(darkFontGrey).make(),

                      //  buttons section
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          itemDetailButtonList.length,
                              (index) => ListTile(
                            title: "${itemDetailButtonList[index]}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            trailing: const Icon(Icons.arrow_forward),
                          ),
                        ),
                      ),

                      //  product you like section
                      20.heightBox,
                      productsyoumaylike.text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .size(16)
                          .make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              6,
                                  (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    imgP1,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                  10.heightBox,
                                  "Laptop 4Gb/251Gb"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "\$600"
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                  10.heightBox
                                ],
                              )
                                  .box
                                  .white
                                  .roundedSM
                                  .margin(const EdgeInsets.symmetric(horizontal: 4))
                                  .padding(const EdgeInsets.all(8))
                                  .make()),
                        ),
                      ),
                    ],
                    //here our deitail UI is also complete
                  ),
                ),
              )),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
              color: redColor,
              onPress: () {
                if(controller.quanlity.value > 0){
                  controller.addToCart(
                    color: data['p_colors'][controller.colorIndex.value],
                    context: context,
                    vendorID: data['vendor_id'],
                    img: data['p_img'][0],
                    qty: controller.quanlity.value,
                    sellername: data['p_seller'],
                    title: data['p_name'],
                    tprice: controller.totalPrice.value,
                  );
                  VxToast.show(context, msg: "Added to cart");
                }
                else{
                  VxToast.show(context, msg: "Number not enough,Requires to add at least 1");
                }
              },
              textColor: whiteColor,
              title: "Add to cart",
            ),
          ),
        ],
      ),
    ));
  }
}
