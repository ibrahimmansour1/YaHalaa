import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yahalaa/core/shared_widgets/custom_button.dart';
import 'package:yahalaa/core/shared_widgets/more_details_widget.dart';
import 'package:yahalaa/core/utils/constants.dart';
import 'package:yahalaa/features/profile/presentation/views/edit_ptofile_view.dart';
import 'package:yahalaa/features/profile/presentation/views/widgets/profile_header.dart';

import '../../../../../core/utils/services/local_services/cache_helper.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(AppConstants.sp20(context)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProfileHeader(
                  name: CacheHelper.getData(key: "name"),
                  imagePath: CacheHelper.getData(key: "image"),
                  type: CacheHelper.getData(key: "role"),
                ),
                SizedBox(
                  height: AppConstants.height30(context),
                ),
                MoreDetailsWidget(
                    title: "aboutMe".tr(),
                    description: CacheHelper.getData(key: "bio")),
              ],
            ),
          ),
        ),
        DefaultButton(
          onPress: () {
            AppConstants.file = null;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EditProfileView()));
          },
          text: "editProfile".tr(),
        ),
      ],
    );
  }
}
