import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/consts/lists.dart';
import 'package:bnshop/views/home_screen/components/featured_button.dart';
import 'package:bnshop/widgets_common/home_buttons.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchanything,
                  hintStyle: TextStyle(color: textfieldGrey),
                ),
              ),
            ),
            //  swipers brands
            Expanded(
              child:
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                        aspectRatio: 16/9,
                        autoPlay: true,
                        height: 150,
                        itemCount: SliderList.length,
                        itemBuilder: (context,index){
                          return Image.asset(SliderList[index],fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8 )).make();
                        }),
                    10.heightBox,
                    //  deal buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          2, (index) => homeButtons(
                        height: context.screenHeight * 0.15,
                        width: context.screenWidth /2.5,
                        icon: index == 0 ? icTodaysDeal : icFlashDeal,
                        title: index == 0 ? todaydeal : flashsale,
                      )),
                    ),
                    //  2nd swiper
                    10.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16/9,
                        autoPlay: true,
                        height: 150,
                        itemCount: secondSlidersList.length,
                        itemBuilder: (context,index){
                          return Image.asset(secondSlidersList[index],fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8 )).make();
                        }),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3, (index) => homeButtons(
                        height: context.screenHeight * 0.15,
                        width: context.screenWidth /3.5,
                        icon: index == 0 ? icTopCategories : index == 1 ? icBrands : icTopSeller,
                        title: index == 0 ? topcategories : index == 1 ? brand : topSellers,
                      )),
                    ),
                    //featuredcategories
                    20.heightBox,
                    Align(
                        alignment: Alignment.centerLeft,
                        child: featuredcatgories.text.color(darkFontGrey).size(18).fontFamily(semibold).make()
                    ),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(3, (index) => Column(
                          children: [
                            featuredButton(icon: featuredImage1[index],title: featuredTitle1[index]),
                            10.heightBox,
                            featuredButton(icon: featuredImage2[index],title: featuredTitle2[index]),
                          ],
                        )).toList(),
                      ),
                    ),

                    //  featured products

                    20.heightBox,

                    Container(
                      padding: const EdgeInsets.all(12),
                      width:double.infinity,
                      //keo dai  can doi 2 ben
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white.fontFamily(bold).size(18).make(),
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
                      ),
                    ),

                    //  third swipers
                    20.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16/9,
                        autoPlay: true,
                        height: 150,
                        enlargeCenterPage: true,
                        itemCount: secondSlidersList.length,
                        itemBuilder: (context,index){
                          return Image.asset(secondSlidersList[index],fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8 )).make();
                        }),

                    //  all products section
                    20.heightBox,
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: 6,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8),
                        itemBuilder: (context,index)
                        {
                          return Column(
                            children: [
                              Image.asset(imgP5,width: 200,fit: BoxFit.fill,)
                            ],
                          ).box.white.roundedSM.make();
                        })
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
