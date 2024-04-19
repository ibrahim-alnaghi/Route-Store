import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/personalization/presentation/bloc/personalization/personalization_bloc.dart';
import 'core/constants/text_strings.dart';
import 'core/helpers/helper_functions.dart';
import 'core/routes/app_route.dart';
import 'core/theme/theme.dart';

class RouteStore extends StatelessWidget {
  final String route;
  const RouteStore({super.key, required this.route});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (context) => PersonalizationBloc(),
          child: BlocBuilder<PersonalizationBloc, PersonalizationStates>(
            builder: (context, state) {
              return MaterialApp(
                title: AppTexts.appName,
                themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                debugShowCheckedModeBanner: false,
                initialRoute: HelperFunctions.getRoute(),
                onGenerateRoute: (settings) => AppRoutes.onGenerate(settings),
              );
            },
          ),
        );
      },
    );
  }
}
