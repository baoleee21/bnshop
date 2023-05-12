import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/consts/lists.dart';
import 'package:bnshop/views/category_screen/item_detail.dart';
import 'package:bnshop/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
class CategoryDetails extends StatelessWidget {
  final String ? title;
  const CategoryDetails({Key? key,required this.title}) : super(key: key) ;
  // TODO: implement CategoryDetails


  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child:Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child :Row(
                  children: List.generate(6, (index) => "BaBy Clothing".text.fontFamily(semibold).size(13).color(darkFontGrey).makeCentered().box.white.rounded.size(120, 60).margin(EdgeInsets.symmetric(horizontal: 4)).make()),
                ),
              ),

              //  item container
              20.heightBox,
              Expanded(

                  child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 250,mainAxisSpacing: 8,crossAxisSpacing: 8),
                      itemBuilder: (context,index){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              imgP1,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            "Laptop 4Gb/251Gb".text.fontFamily(semibold).color(darkFontGrey).make(),
                            10.heightBox,
                            "\$600".text.color(redColor).fontFamily(bold).size(16).make(),
                            10.heightBox,
                          ],
                        ).box.white.roundedSM.outerShadowSm.margin(EdgeInsets.symmetric(horizontal:4)).padding(EdgeInsets.all(12)).make().onTap(() {
                          Get.to(()=>const ItemDetails(title: "Dummy item"));
                        });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

