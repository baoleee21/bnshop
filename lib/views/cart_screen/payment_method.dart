import 'dart:math';

import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/consts/lists.dart';
import 'package:bnshop/controller/cart_controller.dart';
import 'package:bnshop/views/home_screen/home.dart';
import 'package:bnshop/widgets_common/loading_indicator.dart';
import 'package:bnshop/widgets_common/our_button.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(() => Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 70,
        child: controller.placingOrder.value ?Center(
          child: loadingIndicator(),
        ) : ourButton(
          onPress: () async {
              await controller.placeMyOrder(orderPaymentMethod: paymentMethods[controller.paymentIndex.value],totalAmount: controller.totalP.value);
              await controller.clearCart();
              VxToast.show(context, msg: "Order placed successfully");

              Get.offAll(const Home());
          },
          color: redColor,
          textColor: whiteColor,
          title: "Place My order",
        ),
      ),
      appBar: AppBar(
        title: "Choose Payment Method"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Obx(
              () => Column(
            children: List.generate(paymentMethodImg.length, (index) {
              return GestureDetector(
                  onTap: () {
                    controller.chagePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? redColor
                              : Colors.transparent,
                          width: 4,
                        )),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                            paymentMethodImg[index],
                            width: double.infinity,
                            height: 120,
                            colorBlendMode:controller.paymentIndex.value == index
                                ? BlendMode.darken : BlendMode.color,
                            color: controller.paymentIndex.value == index
                                ? Colors.black.withOpacity(0.3) : Colors.transparent,
                            fit: BoxFit.cover),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                              activeColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(50)),
                              value: true,
                              onChanged: (value) {}),
                        )
                            : Container(),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: paymentMethods[index]
                              .text
                              .white
                              .fontFamily(bold)
                              .make(),
                        )
                      ],
                    ),
                  ));
            }),
          ),
        ),
      ),
    ));
  }
}
