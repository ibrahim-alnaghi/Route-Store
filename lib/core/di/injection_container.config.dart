// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/authentication/data/datasources/authentication_data_sources.dart'
    as _i749;
import '../../features/authentication/data/datasources/authentication_remote_data_source.dart'
    as _i308;
import '../../features/authentication/data/repositories/authentication_data_repo.dart'
    as _i360;
import '../../features/authentication/domain/entities/user_entity.dart'
    as _i399;
import '../../features/authentication/domain/repositories/authentication_domain_repo.dart'
    as _i851;
import '../../features/authentication/domain/usecases/login_use_case.dart'
    as _i938;
import '../../features/authentication/domain/usecases/rest_password_use_case.dart'
    as _i793;
import '../../features/authentication/domain/usecases/send_code_use_case.dart'
    as _i804;
import '../../features/authentication/domain/usecases/sign_up_use_case.dart'
    as _i459;
import '../../features/authentication/domain/usecases/verify_code_use_case.dart'
    as _i121;
import '../../features/cart/data/datasources/cart_data_source.dart' as _i670;
import '../../features/cart/data/datasources/remote/cart_remote_data.dart'
    as _i882;
import '../../features/cart/data/repositories/cart_data_repo.dart' as _i451;
import '../../features/cart/domain/repositories/cart_domain_repo.dart' as _i636;
import '../../features/cart/domain/usecases/add_product_to_cart_use_case.dart'
    as _i802;
import '../../features/cart/domain/usecases/apply_coupon_use_case.dart'
    as _i780;
import '../../features/cart/domain/usecases/get_cart_use_case.dart' as _i488;
import '../../features/cart/presentation/bloc/cart_bloc.dart' as _i517;
import '../../features/checkout/data/datasources/checkout_data_source.dart'
    as _i495;
import '../../features/checkout/data/datasources/remote/checkout_remote_data.dart'
    as _i292;
import '../../features/checkout/data/repositories/checkout_data_repo.dart'
    as _i593;
import '../../features/checkout/domain/repositories/checkout_domain_repo.dart'
    as _i925;
import '../../features/checkout/domain/usecases/place_order_use_case.dart'
    as _i838;
import '../../features/orders/data/datasources/orders_data_source.dart'
    as _i585;
import '../../features/orders/data/datasources/remote/orders_remote_data.dart'
    as _i580;
import '../../features/orders/data/repositories/orders_data_repo.dart' as _i652;
import '../../features/orders/domain/repositories/orders_domain_repo.dart'
    as _i262;
import '../../features/orders/domain/usecases/get_my_orders_use_case.dart'
    as _i313;
import '../../features/personalization/data/datasources/personalization_data_source.dart'
    as _i383;
import '../../features/personalization/data/datasources/remote/personalization_remote_data.dart'
    as _i19;
import '../../features/personalization/data/repositories/personalization_data_repo.dart'
    as _i391;
import '../../features/personalization/domain/repositories/personalization_domain_repo.dart'
    as _i101;
import '../../features/personalization/domain/usecases/add_adress_use_case.dart'
    as _i932;
import '../../features/personalization/domain/usecases/get_adresses_use_case.dart'
    as _i1013;
import '../../features/search/data/datasources/remote/search_remote_data.dart'
    as _i697;
import '../../features/search/data/datasources/search_data_source.dart'
    as _i545;
import '../../features/search/data/repositories/search_data_repo.dart' as _i610;
import '../../features/search/domain/repositories/search_domain_repo.dart'
    as _i853;
import '../../features/search/domain/usecases/search_products_use_case.dart'
    as _i698;
import '../../features/shop/data/datasources/remote/shop_remote_data.dart'
    as _i278;
import '../../features/shop/data/datasources/shop_data_source.dart' as _i481;
import '../../features/shop/data/repositories/shop_data_repo.dart' as _i447;
import '../../features/shop/domain/repositories/shop_domain_repo.dart'
    as _i1057;
import '../../features/shop/domain/usecases/add_to_fav_use_case.dart' as _i947;
import '../../features/shop/domain/usecases/get_brands_use_case.dart' as _i43;
import '../../features/shop/domain/usecases/get_categories_use_case.dart'
    as _i6;
import '../../features/shop/domain/usecases/get_fav_use_case.dart' as _i691;
import '../../features/shop/domain/usecases/get_products_use_case.dart'
    as _i450;
import '../../features/shop/domain/usecases/remove_from_fav_use_case.dart'
    as _i1066;
import '../../features/shop/presentation/blocs/wishlist/wishlist_bloc.dart'
    as _i849;
import '../api/api_service.dart' as _i299;
import 'injection_container.dart' as _i809;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i399.UserEntity>(() => registerModule.userData);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i849.WishlistBloc>(() => registerModule.wishlistBloc);
    gh.lazySingleton<_i517.CartBloc>(() => registerModule.cartBloc);
    gh.lazySingleton<_i299.ApiService>(() => _i299.ApiService(gh<_i361.Dio>()));
    gh.lazySingleton<_i545.SearchDataSource>(
        () => _i697.SearchRemoteData(gh<_i299.ApiService>()));
    gh.lazySingleton<_i585.OrdersDataSource>(
        () => _i580.OrdersRemoteData(gh<_i299.ApiService>()));
    gh.lazySingleton<_i495.CheckoutDataSource>(
        () => _i292.CheckoutRemoteData(gh<_i299.ApiService>()));
    gh.lazySingleton<_i383.PersonalizationDataSource>(
        () => _i19.PersonalizationRemoteData(gh<_i299.ApiService>()));
    gh.lazySingleton<_i481.ShopDataSource>(
        () => _i278.ShopRemoteData(gh<_i299.ApiService>()));
    gh.lazySingleton<_i1057.ShopDomainRepo>(
        () => _i447.ShopDataRepo(gh<_i481.ShopDataSource>()));
    gh.lazySingleton<_i670.CartDataSource>(
        () => _i882.PersonalizationRemoteData(gh<_i299.ApiService>()));
    gh.lazySingleton<_i749.AuthenticationDataSources>(() =>
        _i308.AuthenticationRemoteDataSources(
            apiService: gh<_i299.ApiService>()));
    gh.lazySingleton<_i853.SearchDomainRepo>(
        () => _i610.SearchDataRepo(gh<_i545.SearchDataSource>()));
    gh.lazySingleton<_i101.PersonalizationDomainRepo>(() =>
        _i391.PersonalizationDataRepo(gh<_i383.PersonalizationDataSource>()));
    gh.lazySingleton<_i262.OrdersDomainRepo>(
        () => _i652.OrdersDataRepo(gh<_i585.OrdersDataSource>()));
    gh.lazySingleton<_i851.AuthenticationDomainRepo>(() =>
        _i360.AuthenticationDataRepo(gh<_i749.AuthenticationDataSources>()));
    gh.lazySingleton<_i925.CheckoutDomainRepo>(
        () => _i593.CheckoutDataRepo(gh<_i495.CheckoutDataSource>()));
    gh.lazySingleton<_i313.GetMyOrdersUseCase>(
        () => _i313.GetMyOrdersUseCase(gh<_i262.OrdersDomainRepo>()));
    gh.lazySingleton<_i932.AddAdressUseCase>(
        () => _i932.AddAdressUseCase(gh<_i101.PersonalizationDomainRepo>()));
    gh.lazySingleton<_i1013.GetAdressesUseCase>(
        () => _i1013.GetAdressesUseCase(gh<_i101.PersonalizationDomainRepo>()));
    gh.lazySingleton<_i698.SearchProductsUseCase>(
        () => _i698.SearchProductsUseCase(gh<_i853.SearchDomainRepo>()));
    gh.lazySingleton<_i947.AddToFavUseCase>(
        () => _i947.AddToFavUseCase(gh<_i1057.ShopDomainRepo>()));
    gh.lazySingleton<_i43.GetBrandsUseCase>(
        () => _i43.GetBrandsUseCase(gh<_i1057.ShopDomainRepo>()));
    gh.lazySingleton<_i6.GetCategoriesUseCase>(
        () => _i6.GetCategoriesUseCase(gh<_i1057.ShopDomainRepo>()));
    gh.lazySingleton<_i691.GetFavUseCase>(
        () => _i691.GetFavUseCase(gh<_i1057.ShopDomainRepo>()));
    gh.lazySingleton<_i450.GetProductsUseCase>(
        () => _i450.GetProductsUseCase(gh<_i1057.ShopDomainRepo>()));
    gh.lazySingleton<_i1066.RemoveFromFavUseCase>(
        () => _i1066.RemoveFromFavUseCase(gh<_i1057.ShopDomainRepo>()));
    gh.lazySingleton<_i938.LoginUseCase>(
        () => _i938.LoginUseCase(gh<_i851.AuthenticationDomainRepo>()));
    gh.lazySingleton<_i793.RestPasswordUseCase>(
        () => _i793.RestPasswordUseCase(gh<_i851.AuthenticationDomainRepo>()));
    gh.lazySingleton<_i804.SendCodeUseCase>(
        () => _i804.SendCodeUseCase(gh<_i851.AuthenticationDomainRepo>()));
    gh.lazySingleton<_i459.SignupUseCase>(
        () => _i459.SignupUseCase(gh<_i851.AuthenticationDomainRepo>()));
    gh.lazySingleton<_i121.VerifyCodeUseCase>(
        () => _i121.VerifyCodeUseCase(gh<_i851.AuthenticationDomainRepo>()));
    gh.lazySingleton<_i636.CartDomainRepo>(
        () => _i451.CartDataRepo(gh<_i670.CartDataSource>()));
    gh.lazySingleton<_i802.AddProductToCart>(
        () => _i802.AddProductToCart(gh<_i636.CartDomainRepo>()));
    gh.lazySingleton<_i780.ApplyCouponUseCase>(
        () => _i780.ApplyCouponUseCase(gh<_i636.CartDomainRepo>()));
    gh.lazySingleton<_i488.GetCartUseCase>(
        () => _i488.GetCartUseCase(gh<_i636.CartDomainRepo>()));
    gh.lazySingleton<_i838.PlaceOrderUseCase>(
        () => _i838.PlaceOrderUseCase(gh<_i925.CheckoutDomainRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i809.RegisterModule {}
