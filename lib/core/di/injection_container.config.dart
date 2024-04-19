// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/authentication/data/datasources/authentication_data_sources.dart'
    as _i8;
import '../../features/authentication/data/datasources/authentication_remote_data_source.dart'
    as _i9;
import '../../features/authentication/data/repositories/authentication_data_repo.dart'
    as _i11;
import '../../features/authentication/domain/entities/user_entity.dart' as _i5;
import '../../features/authentication/domain/repositories/authentication_domain_repo.dart'
    as _i10;
import '../../features/authentication/domain/usecases/login_use_case.dart'
    as _i17;
import '../../features/authentication/domain/usecases/rest_password_use_case.dart'
    as _i22;
import '../../features/authentication/domain/usecases/send_code_use_case.dart'
    as _i23;
import '../../features/authentication/domain/usecases/sign_up_use_case.dart'
    as _i28;
import '../../features/authentication/domain/usecases/verify_code_use_case.dart'
    as _i29;
import '../../features/cart/data/datasources/cart_data_source.dart' as _i12;
import '../../features/cart/data/datasources/remote/cart_remote_data.dart'
    as _i13;
import '../../features/cart/data/repositories/cart_data_repo.dart' as _i15;
import '../../features/cart/domain/repositories/cart_domain_repo.dart' as _i14;
import '../../features/cart/domain/usecases/add_product_to_cart_use_case.dart'
    as _i31;
import '../../features/cart/domain/usecases/get_cart_use_case.dart' as _i16;
import '../../features/cart/presentation/bloc/cart_bloc.dart' as _i3;
import '../../features/personalization/data/datasources/personalization_data_source.dart'
    as _i18;
import '../../features/personalization/data/datasources/remote/personalization_remote_data.dart'
    as _i19;
import '../../features/personalization/data/repositories/personalization_data_repo.dart'
    as _i21;
import '../../features/personalization/domain/repositories/personalization_domain_repo.dart'
    as _i20;
import '../../features/personalization/domain/usecases/add_adress_use_case.dart'
    as _i30;
import '../../features/personalization/domain/usecases/get_adresses_use_case.dart'
    as _i33;
import '../../features/shop/data/datasources/remote/shop_remote_data.dart'
    as _i25;
import '../../features/shop/data/datasources/shop_data_source.dart' as _i24;
import '../../features/shop/data/repositories/shop_data_repo.dart' as _i27;
import '../../features/shop/domain/repositories/shop_domain_repo.dart' as _i26;
import '../../features/shop/domain/usecases/add_to_fav_use_case.dart' as _i32;
import '../../features/shop/domain/usecases/get_brands_use_case.dart' as _i34;
import '../../features/shop/domain/usecases/get_categories_use_case.dart'
    as _i35;
import '../../features/shop/domain/usecases/get_fav_use_case.dart' as _i36;
import '../../features/shop/domain/usecases/get_products_use_case.dart' as _i37;
import '../../features/shop/domain/usecases/remove_from_fav_use_case.dart'
    as _i38;
import '../../features/shop/presentation/blocs/wishlist/wishlist_bloc.dart'
    as _i6;
import '../api/api_service.dart' as _i7;
import 'injection_container.dart' as _i39;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.CartBloc>(() => registerModule.cartBloc);
    gh.lazySingleton<_i4.Dio>(() => registerModule.dio);
    gh.factory<_i5.UserEntity>(() => registerModule.userData);
    gh.lazySingleton<_i6.WishlistBloc>(() => registerModule.wishlistBloc);
    gh.lazySingleton<_i7.ApiService>(() => _i7.ApiService(gh<_i4.Dio>()));
    gh.lazySingleton<_i8.AuthenticationDataSources>(() =>
        _i9.AuthenticationRemoteDataSources(apiService: gh<_i7.ApiService>()));
    gh.lazySingleton<_i10.AuthenticationDomainRepo>(
        () => _i11.AuthenticationDataRepo(gh<_i8.AuthenticationDataSources>()));
    gh.lazySingleton<_i12.CartDataSource>(
        () => _i13.PersonalizationRemoteData(gh<_i7.ApiService>()));
    gh.lazySingleton<_i14.CartDomainRepo>(
        () => _i15.CartDataRepo(gh<_i12.CartDataSource>()));
    gh.lazySingleton<_i16.GetCartUseCase>(
        () => _i16.GetCartUseCase(gh<_i14.CartDomainRepo>()));
    gh.lazySingleton<_i17.LoginUseCase>(
        () => _i17.LoginUseCase(gh<_i10.AuthenticationDomainRepo>()));
    gh.lazySingleton<_i18.PersonalizationDataSource>(
        () => _i19.PersonalizationRemoteData(gh<_i7.ApiService>()));
    gh.lazySingleton<_i20.PersonalizationDomainRepo>(() =>
        _i21.PersonalizationDataRepo(gh<_i18.PersonalizationDataSource>()));
    gh.lazySingleton<_i22.RestPasswordUseCase>(
        () => _i22.RestPasswordUseCase(gh<_i10.AuthenticationDomainRepo>()));
    gh.lazySingleton<_i23.SendCodeUseCase>(
        () => _i23.SendCodeUseCase(gh<_i10.AuthenticationDomainRepo>()));
    gh.lazySingleton<_i24.ShopDataSource>(
        () => _i25.ShopRemoteData(gh<_i7.ApiService>()));
    gh.lazySingleton<_i26.ShopDomainRepo>(
        () => _i27.ShopDataRepo(gh<_i24.ShopDataSource>()));
    gh.lazySingleton<_i28.SignupUseCase>(
        () => _i28.SignupUseCase(gh<_i10.AuthenticationDomainRepo>()));
    gh.lazySingleton<_i29.VerifyCodeUseCase>(
        () => _i29.VerifyCodeUseCase(gh<_i10.AuthenticationDomainRepo>()));
    gh.lazySingleton<_i30.AddAdressUseCase>(
        () => _i30.AddAdressUseCase(gh<_i20.PersonalizationDomainRepo>()));
    gh.lazySingleton<_i31.AddProductToCart>(
        () => _i31.AddProductToCart(gh<_i14.CartDomainRepo>()));
    gh.lazySingleton<_i32.AddToFavUseCase>(
        () => _i32.AddToFavUseCase(gh<_i26.ShopDomainRepo>()));
    gh.lazySingleton<_i33.GetAdressesUseCase>(
        () => _i33.GetAdressesUseCase(gh<_i20.PersonalizationDomainRepo>()));
    gh.lazySingleton<_i34.GetBrandsUseCase>(
        () => _i34.GetBrandsUseCase(gh<_i26.ShopDomainRepo>()));
    gh.lazySingleton<_i35.GetCategoriesUseCase>(
        () => _i35.GetCategoriesUseCase(gh<_i26.ShopDomainRepo>()));
    gh.lazySingleton<_i36.GetFavUseCase>(
        () => _i36.GetFavUseCase(gh<_i26.ShopDomainRepo>()));
    gh.lazySingleton<_i37.GetProductsUseCase>(
        () => _i37.GetProductsUseCase(gh<_i26.ShopDomainRepo>()));
    gh.lazySingleton<_i38.RemoveFromFavUseCase>(
        () => _i38.RemoveFromFavUseCase(gh<_i26.ShopDomainRepo>()));
    return this;
  }
}

class _$RegisterModule extends _i39.RegisterModule {}
