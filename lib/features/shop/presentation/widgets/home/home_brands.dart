import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/helpers/extensions.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/widgets/shimmer/category_shimmer.dart';
import '../../../../../core/widgets/texts/vertical_image_text.dart';
import '../../blocs/home/home_bloc.dart';

class HomeBrands extends StatelessWidget {
  const HomeBrands({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(
      builder: (context, state) {
        if (state.brands == null) {
          return const CategoryShimmer();
        } else if (state.brands != null && state.brands!.isNotEmpty) {
          return SizedBox(
            height: 80.h,
            child: ListView.builder(
              itemCount: state.brands!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return VerticalImageText(
                  image: state.brands![index].brandImage,
                  title: state.brands![index].brandName,
                  onTap: () =>
                      context.pushNamed(Routes.allProducts, arguments: {
                    'queryParameters': {'brand': state.brands![index].brandID},
                    'title': state.brands![index].brandName
                  }),
                );
              },
            ),
          );
        }
        return const Center(
          child: Text('No Data Found'),
        );
      },
    );
  }
}
