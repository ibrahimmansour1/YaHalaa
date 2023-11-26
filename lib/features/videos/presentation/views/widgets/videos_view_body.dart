import 'package:flutter/material.dart';
import 'package:yahalaa/core/shared_widgets/custom_back_button.dart';
import 'package:yahalaa/core/shared_widgets/main_title_component.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/utils/constants.dart';
import 'chewi_list_item.dart';
import 'chewie_list_view.dart';

class VideosViewBody extends StatelessWidget {
  const VideosViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppConstants.width20(context)),
            child: const MainTitleComponent(title: "Videos"),
          ),
          SizedBox(
            height: AppConstants.height20(context),
          ),
          const ChewieListView(),
        ],
      ),
    );
  }
}
