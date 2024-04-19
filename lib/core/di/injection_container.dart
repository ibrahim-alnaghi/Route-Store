import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:route_store/features/cart/presentation/bloc/cart_bloc.dart';

import '../../features/authentication/domain/entities/user_entity.dart';
import '../../features/shop/presentation/blocs/wishlist/wishlist_bloc.dart';
import '../constants/keys_constants.dart';
import '../local_storage/cache_helper.dart';
import 'injection_container.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio {
    Dio dio = Dio();

    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return dio;
  }

  UserEntity get userData {
    var userMap = CacheHelper.getMapData(userkey);

    if (userMap != null) {
      UserEntity user = UserEntity.fromJson(userMap);
      return user;
    } else {
      return const UserEntity(userToken: '', userName: '', userEmail: '');
    }
  }

  @lazySingleton
  WishlistBloc get wishlistBloc => WishlistBloc(
      addToFavUseCase: getIt(),
      removeFromFavUseCase: getIt(),
      getFavUseCase: getIt());
  @lazySingleton
  CartBloc get cartBloc => CartBloc(getCartUseCase: getIt(), addProductToCart: getIt());
}
