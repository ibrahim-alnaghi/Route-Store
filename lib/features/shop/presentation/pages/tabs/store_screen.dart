import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../../../core/widgets/app_bar/custom_tab_bar.dart';
import '../../../../../core/widgets/products/cart/cart_counter_icon.dart';
import '../../../../../core/widgets/shimmer/shimmer.dart';
import '../../blocs/store/store_bloc.dart';
import '../../widgets/store/category_tab.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StoreBloc, StoreStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return DefaultTabController(
          length: state.categories?.length ?? 10,
          child: Scaffold(
              appBar: CustomAppBar(
                title: Text(
                  'Store',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                actions: [
                  CartCounterIcon(
                    onPressed: () => context.pushNamed(Routes.cartScreen),
                  )
                ],
              ),
              body: Column(
                children: [
                  CustomTabBar(
                    tabs: state.categories?.reversed
                            .map((e) => Tab(
                                  text: e.categoryName,
                                ))
                            .toList() ??
                        List.generate(
                            10,
                            (index) => const Tab(
                                  child: ShimmerEffect(
                                    width: 80,
                                    height: 20,
                                  ),
                                )),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: state.categories?.reversed
                              .map((e) => CategoryTab(
                                    category: e,
                                  ))
                              .toList() ??
                          List.generate(10, (index) => const SizedBox.shrink()),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
