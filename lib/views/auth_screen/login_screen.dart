import 'dart:developer';

import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/consts/lists.dart';
import 'package:bnshop/controller/auth_controller.dart';
import 'package:bnshop/views/auth_screen/signup_screen.dart';
import 'package:bnshop/views/home_screen/home.dart';
import 'package:bnshop/widgets_common/applogo_widget.dart';
import 'package:bnshop/widgets_common/bg_widget.dart';
import 'package:bnshop/widgets_common/custom_textfield.dart';
import 'package:bnshop/widgets_common/our_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthCotroller());
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
            Obx(() => Column(
              children: [
                customTextField(
                    title: email,
                    hint: emailHint,
                    isPass: false,
                    controller: controller.emailController),
                customTextField(
                    hint: passwordHint,
                    title: password,
                    isPass: true,
                    controller: controller.passwordController),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () async {
                          await controller
                              .loginMethod(context: context)
                              .then((value) {
                            if (value != null) {
                              log('mess');
                              VxToast.show(context, msg: loggeIn);
                              Get.offAll(() => const Home());
                            }
                          });
                        },
                        child: forgetPassword.text.make())),
                5.heightBox,
                controller.isloading.value? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ): ourButton(
                    color: redColor,
                    title: login,
                    textColor: whiteColor,
                    onPress: () async {
                      controller.isloading(true);

                      await controller.loginMethod(context: context).then((value){
                        if(value != null){
                          VxToast.show(context, msg: loggeIn);
                          Get.offAll(()=> const Home());
                        }else{
                          controller.isloading(false);
                        }
                      });
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
                .make(),)
          ],
        ),
      ),
    ));
  }
}
