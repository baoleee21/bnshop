import 'dart:io';

import 'package:bnshop/controller/profile_controller.dart';
import 'package:bnshop/views/profile_screen/profile_screen.dart';
import 'package:bnshop/widgets_common/bg_widget.dart';
import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/widgets_common/custom_textfield.dart';
import 'package:bnshop/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller  = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
       appBar:AppBar(),
        body: Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty ? Image.asset(imgProfile2,width: 100,fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make() :
              data['imageUrl'] != '' && controller.profileImgPath.isEmpty ?
                  Image.network(data['imageUrl'],width: 100,height: 80,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():
              Image.file(
              File(controller.profileImgPath.value),
              width: 100,
              height: 70,
              fit: BoxFit.cover,
            ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ourButton(color: redColor,onPress: ()  {
              controller.changeImg(context);
            },textColor: whiteColor,title: "Change"),
            const Divider(),
            20.heightBox,
            customTextField(
                controller: controller.nameController,
                hint: nameHint,
                title: name,
                isPass: false
            ),
            10.heightBox,
            customTextField(
                controller: controller.oldpassController,
                hint: passwordHint,
                title: oldpass,
                isPass: true
            ),
            10.heightBox,
            customTextField(
                controller: controller.newpassController,
                hint: passwordHint,
                title: newpass,
                isPass: true
            ),
            20.heightBox,
            controller.isloading.value ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
            ): SizedBox(
              width: context.screenWidth-60,
              child: ourButton(color: redColor,onPress: ()async{
                controller.isloading(true);
                if(controller.profileImgPath.value.isNotEmpty){
                  await controller.uploadProfileImgage();
                }else{
                  controller.profileImageLink = data['imageUrl'];
                }

                if(data['password']== controller.oldpassController.text){

                  await controller.chageAuthPassword(
                    email: data['email'],
                    password : controller.oldpassController.text,
                    newpassword: controller.newpassController.text,
                  );

                  await controller.updateProfile(
                      imgUrl: controller.profileImageLink,
                      name: controller.nameController.text,
                      password: controller.newpassController.text
                  );
                  VxToast.show(context, msg: "Upload");
                }else{
                  VxToast.show(context, msg: "Wrong old password");
                  controller.isloading(false);
                }

              },textColor: whiteColor,title: "Save"),
            ),
          ],
        ).box.white.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50,left: 10,right: 10)).rounded.make(),),
      )
    );
  }
}
