import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/consts/lists.dart';
import 'package:bnshop/views/auth_screen/signup_screen.dart';
import 'package:bnshop/views/home_screen/home.dart';
import 'package:bnshop/widgets_common/applogo_widget.dart';
import 'package:bnshop/widgets_common/bg_widget.dart';
import 'package:bnshop/widgets_common/custom_textfield.dart';
import 'package:bnshop/widgets_common/our_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            "Login to $appname".text.white.fontFamily(bold).size(18).make(),
            15.heightBox,
            Column(
              children: [
                customTextField(title: email, hint: emailHint, isPass: false),
                customTextField(
                    hint: passwordHint, title: password, isPass: true),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {}, child: forgetPassword.text.make())),
                5.heightBox,
                ourButton(
                    color: redColor,
                    title: login,
                    textColor: whiteColor,
                    onPress: () {
                      Get.to(() => Home());
                    }).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                creatNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                ourButton(
                    color: lightGoden,
                    title: sigup,
                    textColor: redColor,
                    onPress: () {
                      Get.to(() => const SignupScreen());
                    }).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                loginwith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            ),
                          )),
                ),
              ],
            )
                .box
                .white
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ],
        ),
      ),
    ));
  }
}
