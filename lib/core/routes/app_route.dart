import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/personalization/presentation/bloc/adresses/adresses_bloc.dart';
import '../../features/shop/presentation/blocs/all_products/all_products_bloc.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/cart/presentation/pages/cart.dart';
import '../../features/checkout/presentation/bloc/checkout_bloc.dart';
import '../../features/checkout/presentation/pages/checkout.dart';
import '../../features/personalization/presentation/pages/add_new_address.dart';
import '../../features/personalization/presentation/pages/address.dart';
import '../../features/personalization/presentation/pages/orders.dart';
import '../../features/product_details/presentation/blocs/product_details/product_details_bloc.dart';
import '../../features/product_details/presentation/pages/product_details.dart';
import '../../features/product_details/presentation/pages/product_reviews.dart';
import '../../features/shop/presentation/pages/all_products.dart';

import '../../features/authentication/presentation/blocs/forgot_password/forgot_password_bloc.dart';
import '../../features/authentication/presentation/blocs/login/login_bloc.dart';
import '../../features/authentication/presentation/blocs/signup/signup_bloc.dart';
import '../../features/authentication/presentation/pages/forget_password.dart';
import '../../features/authentication/presentation/pages/login.dart';
import '../../features/authentication/presentation/pages/otp_screen.dart';
import '../../features/authentication/presentation/pages/rest_password.dart';
import '../../features/authentication/presentation/pages/signup.dart';
import '../../features/onboarding/presentation/bloc/onboarding_bloc.dart';
import '../../features/onboarding/presentation/pages/onboarding.dart';
import '../../features/shop/domain/entities/product_entity/product_entity.dart';
import '../../features/shop/presentation/blocs/shop/shop_bloc.dart';
import '../../features/shop/presentation/pages/navigation_menu.dart';
import '../../features/personalization/presentation/pages/profile.dart';
import '../di/injection_container.dart';
import '../widgets/success_screen/success_screen.dart';
import 'routes.dart';

class AppRoutes {
  static Route? onGenerate(RouteSettings routeSettings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    final arguments = routeSettings.arguments;
    switch (routeSettings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => OnboardingBloc(),
            child: const OnboardingScreen(),
          ),
        );
      case Routes.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginBloc(loginUseCase: getIt()),
            child: const LoginScreen(),
          ),
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ForgotPasswordBloc(
                sendCodeUseCase: getIt(),
                verifyCodeUseCase: getIt(),
                restPasswordUseCase: getIt()),
            child: const ForgetPassword(),
          ),
        );
      case Routes.otpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ForgotPasswordBloc(
                sendCodeUseCase: getIt(),
                verifyCodeUseCase: getIt(),
                restPasswordUseCase: getIt()),
            child: const OtpScreen(),
          ),
        );
      case Routes.restPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ForgotPasswordBloc(
                sendCodeUseCase: getIt(),
                verifyCodeUseCase: getIt(),
                restPasswordUseCase: getIt()),
            child: const RestPassword(),
          ),
        );
      case Routes.signup:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SignupBloc(signupUseCase: getIt()),
            child: const SignupScreen(),
          ),
        );
      case Routes.successScreen:
        return MaterialPageRoute(
          builder: (context) => SuccessScreen(
            screenModel: arguments as SuccessScreenModel,
          ),
        );
      case Routes.shop:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ShopBloc(),
            child: const NavigationMenu(),
          ),
        );

      case Routes.allProducts:
        arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AllProductsBloc(getProductsUseCase: getIt())
              ..add(GetAllProducts(
                  queryParameters: arguments['queryParameters'])),
            child: AllProducts(
              title: arguments['title'],
              queryParameters: arguments['queryParameters'],
            ),
          ),
        );

      case Routes.productDetails:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProductDetailsBloc()
              ..add(ImageSelected(arguments.productImages.first)),
            child: ProductDetails(
              productEntity: arguments as ProductEntity,
            ),
          ),
        );
      case Routes.productReviews:
        return MaterialPageRoute(
          builder: (context) => const ProductReviewsScreen(),
        );
      case Routes.cartScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<CartBloc>()..add(GetCart()),
            child: const CartScreen(),
          ),
        );
      case Routes.checkoutScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => CheckoutBloc(),
            child: const CheckoutScreen(),
          ),
        );
      case Routes.userProfileScreen:
        return MaterialPageRoute(
          builder: (context) => const UserProfileScreen(),
        );
      case Routes.userAddressScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AdressesBloc(
                getAdressesUseCase: getIt(), addAdressUseCase: getIt())
              ..add(GetAdresses()),
            child: const UserAddressScreen(),
          ),
        );
      case Routes.addNewAddressScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AdressesBloc(
                getAdressesUseCase: getIt(), addAdressUseCase: getIt()),
            child: const AddNewAddressScreen(),
          ),
        );
      case Routes.orderScreen:
        return MaterialPageRoute(
          builder: (context) => const OrderScreen(),
        );

      default:
        return null;
    }
  }
}
