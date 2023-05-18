import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/consts/lists.dart';
import 'package:bnshop/controller/product_controller.dart';
import 'package:bnshop/services/firestore_services.dart';
import 'package:bnshop/views/category_screen/item_detail.dart';
import 'package:bnshop/widgets_common/bg_widget.dart';
import 'package:bnshop/widgets_common/loading_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);
  // TODO: implement CategoryDetails

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getProduct(title),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: loadingIndicator(),
                );
              }else if(snapshot.data!.docs.isEmpty){
                return Center(
                  child: "No products found!".text.color(darkFontGrey).make(),
                );
              }
              else{
                var data = snapshot.data!.docs;

                return Container(
                  padding: const EdgeInsets.all(12),
                  child:Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child :Row(
                          children: List.generate(controller.subCat.length, (index) => "${controller.subCat[index]}".text.fontFamily(semibold).size(10).color(darkFontGrey).makeCentered().box.white.rounded.size(120, 60).margin(EdgeInsets.symmetric(horizontal: 4)).make()),
                        ),
                      ),

                      //  item container
                      20.heightBox,
                      Expanded(

                          child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 250,mainAxisSpacing: 8,crossAxisSpacing: 8),
                              itemBuilder: (context,index){
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      data[index]['p_img'][0],
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                    10.heightBox,
                                    "${data[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                                    10.heightBox,
                                  ],
                                ).box.white.roundedSM.outerShadowSm.margin(EdgeInsets.symmetric(horizontal:4)).padding(EdgeInsets.all(12)).make().onTap(() {
                                  controller.checkIfFav(data[index]);
                                  Get.to(()=>ItemDetails(
                                      title: "${data[index]['p_name']}",
                                      data: data[index],

                                  ));
                                });
                              }))
                    ],
                  ),
                );
              }
            }
        ),
      ),
    );
  }
}
