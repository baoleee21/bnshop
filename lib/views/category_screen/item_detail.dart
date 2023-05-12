import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/consts/lists.dart';
import 'package:bnshop/widgets_common/our_button.dart';
class ItemDetails extends StatelessWidget {
  final String? title;
  const ItemDetails ({Key? key,required this.title}) : super(key: key);

  //welcome to episode
  //here we are going to continue building our UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.share,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.favorite_outline,))
        ],
      ),
      body:Column(
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
                          aspectRatio: 16/9,
                          itemCount: 3,
                          itemBuilder: (context,index)
                          {
                            return Image.asset(imgFc5 , width: double.infinity,fit: BoxFit.cover,);
                          }),
                      10.heightBox,
                      title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                      10.heightBox,
                      //  rating
                      VxRating(onRatingUpdate: (value){},normalColor: textfieldGrey,selectionColor: golden,count : 5,size: 25,stepInt: true,),
                      10.heightBox,
                      "\$30.000".text.fontFamily(bold).color(redColor).size(18).make(),

                      10.heightBox,
                      Row(
                        children: [
                          Expanded(child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "In House Brands".text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
                            ],
                          )),
                          const CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(Icons.message_rounded,color: darkFontGrey,),
                          )
                        ],
                      ).box.height(60).padding(EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),

                      //  Color section
                      20.heightBox,
                      Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color : ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(3, (index) => VxBox().size(40, 40).roundedFull.color(Vx.randomPrimaryColor).margin(const EdgeInsets.symmetric(horizontal: 4)).make()),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          //quanlity row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total : ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: [

                                ],
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total : ".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: [
                                  IconButton(onPressed: (){}, icon:const Icon(Icons.remove)),
                                  "0".text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                  IconButton(onPressed: (){}, icon:const Icon(Icons.add)),
                                ],
                              ),
                              "\$0.00".text.color(redColor).size(16).fontFamily(bold).make(),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),


                        ],
                      ).box.white.shadowSm.make(),

                      //  description section
                      10.heightBox,
                      "Description".text.color(darkFontGrey).fontFamily(semibold).make(),
                      10.heightBox,
                      "This is a dummy item and dummy description here.. it's beautiful,cotton good..le van bao rat dep trai goodboy".text.color(darkFontGrey).make(),

                      //  buttons section
                      ListView(
                        shrinkWrap: true,
                        physics:const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          itemDetailButtonList.length,
                              (index) => ListTile(
                            title: "${itemDetailButtonList[index]}".text.fontFamily(semibold).color(darkFontGrey).make(),
                            trailing: const Icon(Icons.arrow_forward),
                          ),),
                      ),

                      //  product you like section
                      20.heightBox,
                      productsyoumaylike.text.fontFamily(bold).color(darkFontGrey).size(16).make(),
                      10.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                              6, (index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                imgP1,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                              10.heightBox,
                              "Laptop 4Gb/251Gb".text.fontFamily(semibold).color(darkFontGrey).make(),
                              10.heightBox,
                              "\$600".text.color(redColor).fontFamily(bold).size(16).make(),
                              10.heightBox
                            ],
                          ).box.white.roundedSM.margin(EdgeInsets.symmetric(horizontal:4)).padding(EdgeInsets.all(8)).make()),
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
              onPress: (){},
              textColor: whiteColor,
              title: "Add to cart",
            ),
          ),
        ],
      ),
    );
  }
}
