import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/consts/firebase_const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthCotroller extends GetxController {
  var isloading = false.obs;

  //textcontroller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

//  login method

  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;

    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//  signup method
  Future<UserCredential?> signupMethod(email, password, context) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print("Alan Bảo - Võ Thị Ngọc");
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//  storing method
  storeUserData({name, password, email}) async {
    DocumentReference store =
        await firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      'cart_count': "00",
      'order_count':"00",
      'wishlist_count':"00",
    });
  }

//signout Method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
