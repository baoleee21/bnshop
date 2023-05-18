import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
  var quanlity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

  var subCat = [];
  var isFav= false.obs;

  getSubCategories(title) async{
    subCat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categorymodelsFromJson(data);
    var s = decoded.categories.where((element) => element.name == title).toList();
    for(var e in s[0].subcategory){
      subCat.add(e);
    }
  }

  chageColorIndex(index){
    colorIndex.value = index;
  }

  increaseQuanlity(totalQuanlity){
    if(quanlity.value < totalQuanlity){
      quanlity.value++;
    }
  }
  decreaseQuality(){
    if(quanlity.value >0){
      quanlity.value--;
    }
  }
  caculatorTotalPrice(price){
    totalPrice.value = price * quanlity.value;
  }
  addToCart({
    title,img,sellername,color,qty,tprice,context,vendorID
  }) async{
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img':img,
      'sellername':sellername,
      'color':color,
      'vendor_id':vendorID,
      'qty': qty,
      'tprice':tprice,
      'added_by': currentUser!.uid
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues(){
    totalPrice.value = 0;
    quanlity.value = 0;
    colorIndex.value = 0;
    isFav.value = false;
  }
  addToWishlist(docId,context) async{
    await firestore.collection(productCollection).doc().set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    },SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Add to wishlist");
  }
  removeFromWishlist(docId,context) async{
    await firestore.collection(productCollection).doc().set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    },SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Remove from wishlist");
  }
  checkIfFav(data) async{
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }
    else{
      isFav(false);
    }
  }
}