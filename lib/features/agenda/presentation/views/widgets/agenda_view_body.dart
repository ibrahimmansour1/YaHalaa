import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yahalaa/core/shared_widgets/agenda_item.dart';
import 'package:yahalaa/core/shared_widgets/custom_back_button.dart';
import 'package:yahalaa/core/shared_widgets/event_time_line.dart';
import 'package:yahalaa/core/utils/colors/colors.dart';

import '../../../../../../core/utils/constants.dart';
import '../../../../../core/shared_widgets/error_widget.dart';
import '../../../../../core/utils/assets/assets.dart';
import '../../../../../core/utils/services/local_services/cache_helper.dart';
import '../../view_models/dated_all_sessions_cubit/dated_all_sessions_cubit.dart';

class AgendaViewBody extends StatefulWidget {
  const AgendaViewBody({super.key});

  @override
  State<AgendaViewBody> createState() => _AgendaViewBodyState();
}

class _AgendaViewBodyState extends State<AgendaViewBody> {
  final List<Color> colors = <Color>[
    AppColors.primarySwatchColor,
    AppColors.secondaryColor,
    const Color(0xcc323232)
  ];
  var date;
  @override
  void initState() {
    date = DateTime.now().isBefore(
      DateTime(
          int.parse(CacheHelper.getData(key: "event_start_day").split("-")[0]),
          int.parse(CacheHelper.getData(key: "event_start_day").split("-")[1]),
          int.parse(CacheHelper.getData(key: "event_start_day").split("-")[2])),
    )
        ? date = DateTime(
            int.parse(
                CacheHelper.getData(key: "event_start_day").split("-")[0]),
            int.parse(
                CacheHelper.getData(key: "event_start_day").split("-")[1]),
            int.parse(
                CacheHelper.getData(key: "event_start_day").split("-")[2]))
        : DateTime.now();
    context.read<DatedAllSessionsCubit>().datedAllSessionsDetails(query: {
      "date": DateFormat('yyyy-MM-dd', "en").format(date),
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppConstants.height20(context),
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppConstants.width20(context)),
          child: const CustomBackButton(),
        ),
        SizedBox(
          height: AppConstants.height20(context),
        ),
        EventTimeLine(
          openClick: true,
          all: true,
        ),
        SizedBox(
          height: AppConstants.height20(context),
        ),
        BlocBuilder<DatedAllSessionsCubit, DatedAllSessionsState>(
          builder: (context, state) {
            if (state is UserDatedAllSessionsSuccessState) {
              return state.model.data!.isNotEmpty
                  ? Expanded(
                      child: ListView.separated(
                        itemCount: state.model.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          print("${index % 3}");
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppConstants.width20(context)),
                            child: AgendaItem(
                              instance: state.model.data![index],
                              color: colors[index % 3],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: AppConstants.height10(context),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AssetData.noSessions,
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width * .5,
                        ),
                      ],
                    ));
            } else if (state is UserDatedAllSessionsLoadingState) {
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state is UserDatedAllSessionsErrorState) {
              return Expanded(
                child: CustomErrorWidget(
                  onTap: () {
                    context
                        .read<DatedAllSessionsCubit>()
                        .datedAllSessionsDetails(query: {
                      "date": DateFormat('yyyy-MM-dd', "en").format(date),
                    });
                  },
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
