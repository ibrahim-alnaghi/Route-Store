import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../personalization/presentation/pages/settings_screen.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/shop/shop_bloc.dart';
import '../blocs/store/store_bloc.dart';
import 'tabs/home_screen.dart';
import 'tabs/store_screen.dart';
import 'tabs/wishlist_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<ShopBloc, ShopStates>(
        builder: (context, state) {
          return NavigationBar(
              height: 80.h,
              elevation: 0,
              selectedIndex: state.selectedIndex,
              backgroundColor: HelperFunctions.isDarkMode(context)
                  ? AppColors.black
                  : Colors.white,
              indicatorColor: HelperFunctions.isDarkMode(context)
                  ? AppColors.white.withOpacity(0.1)
                  : AppColors.black.withOpacity(0.1),
              onDestinationSelected: (value) {
                context.read<ShopBloc>().add(SelectNavigationEvent(value));
              },
              destinations: const [
                NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
                NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
                NavigationDestination(
                    icon: Icon(Iconsax.heart), label: 'Wishlist'),
                NavigationDestination(
                    icon: Icon(Iconsax.user), label: 'Profile'),
              ]);
        },
      ),
      body: BlocBuilder<ShopBloc, ShopStates>(
        builder: (context, state) {
          switch (state.selectedIndex) {
            case 0:
              return BlocProvider(
                create: (context) => HomeBloc(
                    getBrandsUseCase: getIt(), getProductsUseCase: getIt())
                  ..add(GetCategories())
                  ..add(const GetProducts(
                      queryParameters: {'limit': 4, 'sort': '-price'})),
                child: const HomeScreen(),
              );
            case 1:
              return BlocProvider(
                create: (context) => StoreBloc(
                    getCategoriesUseCase: getIt(), getProductsUseCase: getIt())
                  ..add(GetStoreCategories()),
                child: const StoreScreen(),
              );
            case 2:
              return const WishlistScreen();
            case 3:
              return const SettingsScreen();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
