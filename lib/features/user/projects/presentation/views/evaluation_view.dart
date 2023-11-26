import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yahalaa/features/user/projects/presentation/views/widgets/evaluation_view_body.dart';

class EvaluationView extends StatelessWidget {
  const EvaluationView({super.key, required this.projectId});
  final int projectId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0), // here the desired height
          child: AppBar(
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white, // <-- SEE HERE
              statusBarIconBrightness:
                  Brightness.dark, //<-- For Android SEE HERE (dark icons)
              systemNavigationBarColor: Colors.white,
              statusBarBrightness:
                  Brightness.light, //<-- For iOS SEE HERE (dark icons)
            ),
          )),
      body: EvaluationViewBody(
        projectId: projectId,
      ),
    );
  }
}
