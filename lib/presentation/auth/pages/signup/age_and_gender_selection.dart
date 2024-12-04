import 'package:ecommers/common/bloc/button/button_cubit.dart';
import 'package:ecommers/common/bloc/button/button_state.dart';
import 'package:ecommers/common/helper/bottomsheet/app_bottomsheet.dart';
import 'package:ecommers/common/widget/app_bar/basic_app_bar.dart';
import 'package:ecommers/common/widget/bottons/basic_reactive_button.dart';
import 'package:ecommers/data/auth/model/user_creation_req.dart';
import 'package:ecommers/domain/auth/usecases/sigup_usecases.dart';
import 'package:ecommers/presentation/auth/bloc/sign_up/age/age_selection_cubit.dart';
import 'package:ecommers/presentation/auth/bloc/sign_up/age/ages_display_cubit.dart';
import 'package:ecommers/presentation/auth/bloc/sign_up/gender/gender_selection_cubit.dart';
import 'package:ecommers/presentation/widgets/ages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/theme/app_colors.dart';

class GenderAndAgeSelectionPage extends StatelessWidget {
final UserCreationReq userCreationReq;

  const GenderAndAgeSelectionPage({super.key, required this.userCreationReq});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GenderSelectionCubit(),
        ),
        BlocProvider(
          create: (context) => AgeSelectionCubit(),
        ),
        BlocProvider(
          create: (context) => AgesDisplayCubit(),
        ),
        BlocProvider(
          create: (context) => ButtonCubit(),
        ),
      ],
      child: BlocListener<ButtonCubit, ButtonState>(
  listener: (context, state) {
   if(state is ButtonFailure){
     var snackBar=SnackBar(content: Text(state.errorMessage),behavior: SnackBarBehavior.floating,);

     ScaffoldMessenger.of(context).showSnackBar(snackBar);


   } if(state is ButtonSuccess){

   }
  },
  child: Scaffold(
          appBar: const BasicAppBar(),
          body: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _tellUs(),
                    const SizedBox(
                      height: 30,
                    ),
                    _genders(context),
                    const SizedBox(
                      height: 30,
                    ),
                    howOld(),
                    const SizedBox(
                      height: 30,
                    ),
                    _age(),
                  ],
                ),
              ),
              const Spacer(),
              _finishButton(context)
            ],
          )),
),
    );
  }

  Widget _tellUs() {
    return const Text(
      'Tell us about yourself',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
    );
  }

  Widget _genders(BuildContext context) {
    return BlocBuilder<GenderSelectionCubit, int>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            genderTile(context, 1, 'Men'),
            const SizedBox(
              width: 20,
            ),
            genderTile(context, 2, 'Women'),
          ],
        );
      },
    );
  }

  Expanded genderTile(BuildContext context, int genderIndex, String gender) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          context.read<GenderSelectionCubit>().selectedGender(genderIndex);
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
              color: context.read<GenderSelectionCubit>().selectIndex ==
                      genderIndex
                  ? AppColors.primary
                  : AppColors.secondBackground,
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              gender,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  Widget howOld() {
    return const Text(
      'How old are you?',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    );
  }

  Widget _age() {
    return BlocBuilder<AgeSelectionCubit, String>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            AppBottomSheet.display(
                context,
                MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: context.read<AgeSelectionCubit>(),
                  ),
                  BlocProvider.value(
                    value: context.read<AgesDisplayCubit>()..displayAges(),
                  ),
                ], child: const Ages()));
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: AppColors.secondBackground,
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(state), const Icon(Icons.keyboard_arrow_down)],
            ),
          ),
        );
      },
    );
  }

  Widget _finishButton(BuildContext context) {
    return Container(
      height: 100,
      color: AppColors.secondBackground,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Builder(
          builder: (context) {
            return BasicReactiveButton(onPressed: () {
              userCreationReq.gender=context.read<GenderSelectionCubit>().selectIndex;
              userCreationReq.age=context.read<AgeSelectionCubit>().selectedAge;
              context.read<ButtonCubit>().execute(useCase: SignupUseCase(),
              params: userCreationReq);
            }, title: 'Finish');
          }
        ),
      ),
    );
  }
}
