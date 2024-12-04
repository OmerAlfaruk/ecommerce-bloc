import 'package:ecommers/data/auth/repositories/auth.dart';
import 'package:ecommers/data/categories/repositoryImpl/category.dart';
import 'package:ecommers/data/categories/source/categegory_firebase_service.dart';
import 'package:ecommers/data/order/sources/order_firebase_service.dart';
import 'package:ecommers/data/product/source/product_firebase_servive.dart';
import 'package:ecommers/domain/auth/usecases/get_ages_usecase.dart';
import 'package:ecommers/domain/auth/usecases/get_user_use_case.dart';
import 'package:ecommers/domain/auth/usecases/send_passord_reset_email_usecase.dart';
import 'package:ecommers/domain/category/repository/category.dart';
import 'package:ecommers/domain/order/usecase/add_to_cart_usecase.dart';
import 'package:ecommers/domain/order/usecase/remove_cart_order_usecase.dart';
import 'package:ecommers/domain/product/usecases/get_favorite_usecase.dart';
import 'package:ecommers/domain/product/usecases/get_top_selling_usecase.dart';
import 'package:ecommers/domain/product/usecases/is_favorite_usecase.dart';
import 'package:get_it/get_it.dart';

import 'data/auth/sources/firebase_auth_service.dart';
import 'data/order/repositories/order.dart';
import 'data/product/repositoryImpl/product.dart';
import 'domain/auth/repositories/auth.dart';
import 'domain/auth/usecases/is_logged_in_usecase.dart';
import 'domain/auth/usecases/sign_in_usecase.dart';
import 'domain/auth/usecases/sigup_usecases.dart';
import 'domain/category/usecases/get_category_use_case.dart';
import 'domain/order/repositories/order.dart';
import 'domain/order/usecase/get_cart_product.dart';
import 'domain/order/usecase/get_order_usecase.dart';
import 'domain/order/usecase/order_registration_usecase.dart';
import 'domain/product/repository/product.dart';
import 'domain/product/usecases/add_or_remove_favorite_usecase.dart';
import 'domain/product/usecases/get_new_in_uses_case.dart';
import 'domain/product/usecases/get_product_by_category_Id_usecase.dart';
import 'domain/product/usecases/get_product_by_title_usecase.dart';

final sl=GetIt.instance;
Future<void> initializeDependencies()async{


  /// Sources

  // Authentication
  sl.registerSingleton<AuthFirebaseService>(
      AuthFirebaseServiceImp()
  );

  // Categories

  sl.registerSingleton<CategoryFirebaseService>(
      CategoryFirebaseServiceImpl()
  );

  // Product

  sl.registerSingleton<ProductFirebaseService>(
      ProductFirebaseServiceImpl()
  );

  // Order

  sl.registerSingleton<OrderFirebaseService>(
      OrderFirebaseServiceImpl()
  );


  /// Repositories

  // Authentication

  sl.registerSingleton<AuthRepository>(
      AuthRepositoryImpl()
  );

  // Categories

  sl.registerSingleton<CategoryRepository>(
      CategoryRepositoryImpl()
  );
  // Product

  sl.registerSingleton<ProductRepository>(
      ProductRepositoryImpl()
  );

  // Order

  sl.registerSingleton<OrderRepository>(
      OrderRepositoryImpl()
  );


  /// Authentication
  sl.registerSingleton<SignupUseCase>(
      SignupUseCase()
  );

  sl.registerSingleton<GetAgesUseCase>(
      GetAgesUseCase()
  );


  sl.registerSingleton<SignInUseCase>(
      SignInUseCase()
  );


  sl.registerSingleton<SendPasswordResetEmailUseCase>(
      SendPasswordResetEmailUseCase()
  );

  sl.registerSingleton<IsLoggedInUseCase>(
      IsLoggedInUseCase()
  );

  /// Category

  sl.registerSingleton<GetUserUseCase>(
      GetUserUseCase()
  );



  sl.registerSingleton<GetCategoryUseCase>(
      GetCategoryUseCase()
  );

  /// Product

  sl.registerSingleton<GetTopSellingUseCase>(
      GetTopSellingUseCase()
  );
  sl.registerSingleton<GetNewInUsesCase>(
      GetNewInUsesCase()
  );

  sl.registerSingleton<GetProductByCategoryIdUseCase>(
      GetProductByCategoryIdUseCase()
  );

  sl.registerSingleton<AddOrRemoveFavoriteProductUseCase>(
      AddOrRemoveFavoriteProductUseCase()
  );

  sl.registerSingleton<GetProductByTitleUseCase>(
      GetProductByTitleUseCase()
  );
  sl.registerSingleton<IsFavoriteUseCase>(
      IsFavoriteUseCase()
  );
  sl.registerSingleton<GetFavoriteUseCase>(
      GetFavoriteUseCase()
  );



  // order

  // add To cart

  sl.registerSingleton<AddToCartUseCase>(
      AddToCartUseCase()
  );
  sl.registerSingleton<GetCartProductUseCase>(
      GetCartProductUseCase()
  );
  sl.registerSingleton<RemoveCartOrderUseCase>(
      RemoveCartOrderUseCase()
  );sl.registerSingleton<OrderRegistrationUseCase>(
      OrderRegistrationUseCase()
  );
  sl.registerSingleton<GetOrderUseCase>(
      GetOrderUseCase()
  );

}