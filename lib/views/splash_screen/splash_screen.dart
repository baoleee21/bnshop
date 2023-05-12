import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/views/auth_screen/login_screen.dart';
import 'package:bnshop/widgets_common/applogo_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  //Creat a method to chage screen : tao phuong thuc de dan den man hinh
  changeScreen(){
    Future.delayed(Duration(seconds: 3),(){
      Get.to(()=>const LoginScreen());
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child:Image.asset(icSplashBg,width: 300)),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
            //  our splash screen UI is completed..
          ],
        ),
      ),
    );
  }
}
