import 'dart:developer';

import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/controller/auth_controller.dart';
import 'package:bnshop/views/home_screen/home.dart';
import 'package:bnshop/widgets_common/our_button.dart';
import 'package:bnshop/widgets_common/applogo_widget.dart';
import 'package:bnshop/widgets_common/bg_widget.dart';
import 'package:bnshop/widgets_common/custom_textfield.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? icCheck = false;
  var controller = Get.put(AuthCotroller());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.white.fontFamily(bold).size(18).make(),
            15.heightBox,
            Obx(() => Column(
              children: [
                customTextField(
                    title: name,
                    hint: nameHint,
                    controller: nameController,
                    isPass: false),
                customTextField(
                    title: email,
                    hint: emailHint,
                    controller: emailController,
                    isPass: false),
                customTextField(
                    hint: passwordHint,
                    title: password,
                    controller: passwordController,
                    isPass: true),
                customTextField(
                    hint: passwordHint,
                    title: retypePassword,
                    controller: passwordRetypeController,
                    isPass: true),
                10.heightBox,
                Row(
                  children: [
                    Checkbox(
                      activeColor: redColor,
                      checkColor: whiteColor,
                      value: icCheck,
                      onChanged: (newValue) {
                        setState(() {
                          icCheck = newValue;
                        });
                      },
                    ),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                      fontFamily: regular, color: fontGrey)),
                              TextSpan(
                                  text: termAndCond,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  )),
                              TextSpan(
                                  text: " & ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                  text: privacyPolicy,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: redColor,
                                  )),
                            ],
                          )),
                    ),
                  ],
                ),
                controller.isloading.value? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ): ourButton(
                  color: icCheck == true ? redColor : lightGrey,
                  title: sigup,
                  textColor: whiteColor,
                  onPress: () async {
                    if (icCheck != false) {
                      controller.isloading(true);
                      try {
                        await controller
                            .signupMethod(emailController.text,
                            passwordController.text, context)
                            .then((value) {
                          log(value.toString());
                          return controller.storeUserData(
                              email: emailController.text,
                              name: nameController.text,
                              password: passwordController.text);
                        }).then((value) {
                          log('message');
                          VxToast.show(context, msg: loggeIn);
                          Get.offAll(() => const Home());
                        });
                      } catch (e) {
                        log('mess');
                        auth.signOut();
                        VxToast.show(context, msg: e.toString());
                        controller.isloading(false);
                      }
                    }
                  },
                ).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                //wrappiong into gesture detector of velocity x
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alreadyHaveAccount.text.color(fontGrey).make(),
                    login.text.color(redColor).make().onTap(() {
                      Get.back();
                    })
                  ],
                ),
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),)
          ],
        ),
      ),
    ));
  }
}
