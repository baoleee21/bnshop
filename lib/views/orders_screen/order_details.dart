import 'package:bnshop/consts/consts.dart';
import 'package:bnshop/views/orders_screen/components/order_status.dart';
class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details".text.fontFamily(semibold).make(),
      ),
      body: Column(
        children: [
          orderStatus(
            color: redColor,icon: Icons.done,title: "Placed",showDone:  data['order_placed'],
          ),
          orderStatus(
            color: redColor,icon: Icons.done,title: "Confirmed",showDone:  data['order_confirmed'],
          ),
          orderStatus(
            color: redColor,icon: Icons.done,title: "On Delivery",showDone:  data['order_on_delivery'],
          ),
          orderStatus(
            color: redColor,icon: Icons.done,title: "Delivery",showDone:  data['order_delivered'],
          ),
        ],
      ),
    );
  }
}
