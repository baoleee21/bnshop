import 'package:bnshop/consts/consts.dart';

//get user data
class FirestoreServices{
  static getUser(uid){
    return firestore.collection(usersCollection).where('id',isEqualTo: uid).snapshots();
  }
  static getProduct(category){
    return firestore.collection(productCollection).where('p_category',isEqualTo: category).snapshots();
  }

  static getCart(uid){
    return firestore.collection(cartCollection).where('added_by',isEqualTo: uid).snapshots();
  }
//  delete document
  static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }
  static getChatMessages(docId){
    return firestore.collection(chatsCollection).doc(docId).collection(messageCollection).orderBy('creat_on',descending: false).snapshots();
  }
  static getAllOrders(){
    return firestore.collection(orderCollection).where('order_by',isEqualTo: currentUser!.uid).snapshots();
  }
  static getWishlists(){
    return firestore.collection(productCollection).where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
  }
  static getAllMessages(){
    return firestore.collection(chatsCollection).where('fromId',isEqualTo: currentUser!.uid).snapshots();
  }
}
