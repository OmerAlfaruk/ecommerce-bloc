import 'package:ecommers/common/helper/navigator/app_navigator.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/core/config/theme/app_colors.dart';
import 'package:ecommers/domain/order/entities/order.dart';
import 'package:ecommers/presentation/setting/bloc/order_display_cubit.dart';
import 'package:ecommers/presentation/setting/bloc/order_display_state.dart';
import 'package:ecommers/presentation/setting/pages/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersPage extends StatelessWidget {

  const MyOrdersPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BasicAppBar(
          title: Text('My Orders'),
        ),
        body: BlocProvider(
          create: (context) => OrderDisplayCubit()..displayOrders(),
          child: BlocBuilder<OrderDisplayCubit, OrderDisplayState>(
            builder: (context, state) {
              if (state is OrderDisplayLoading) {
                return Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              }
              if (state is OrderDisplayLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _myOrders(state.orders),
                );
              }
              if (state is OrderDisplayFailure) {
                Center(
                  child: Text(state.errorMessage),
                );
              }
              return Container();
            },
          ),
        ));
  }

  Widget _myOrders(List<OrderEntity> orders) {
   return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: ()=>AppNavigator.push(context,OrderDetailPage(orderEntity: orders[index],)),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 80,
              decoration: BoxDecoration(
                  color: AppColors.secondBackground,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.receipt_rounded),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Order ${orders[index].code}',
                            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                          Text(
                            '${orders[index].products.length} items',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: orders.length);

  }
}
