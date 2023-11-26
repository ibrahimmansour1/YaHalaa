import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yahalaa/core/utils/constants.dart';
import 'package:yahalaa/features/notifications/data/repos/notifications_repo.dart';

import 'notifications_states.dart';

class NotificationsCubit extends Cubit<NotificationsStates> {
  NotificationsCubit(this.notificationsRepo) : super(NotificationsInitState());

  static NotificationsCubit get(context) => BlocProvider.of(context);

  NotificationsRepo? notificationsRepo;

  int notificationsListLength = 0;
  static int l = 0;
  Future<void> getNotificationsData() async {
    emit(GetAllNotificationsDataLoadingState());
    var result = await notificationsRepo!.getNotificationsData();
    return result.fold((failure) {
      emit(GetAllNotificationsDataErrorState(failure.errMessage));
      print(failure.errMessage);
    }, (data) {
      emit(GetAllNotificationsDataSuccessState(data));
      notificationsListLength = data.data!.length;
    });
  }

  deleteOneNotifications({required int notifyId}) async {
    emit(DeleteOneNotificationsLoadingState());
    var result =
        await notificationsRepo!.deleteOneNotification(notifyId: notifyId);
    return result.fold((failure) {
      emit(DeleteOneNotificationsErrorState(failure.errMessage));
      print(failure.errMessage);
    }, (data) {
      emit(DeleteOneNotificationsSuccessState(data));
    });
  }

  deleteAllNotifications() async {
    emit(DeleteAllNotificationsLoadingState());
    var result = await notificationsRepo!.deleteAllNotifications();
    return result.fold((failure) {
      emit(DeleteAllNotificationsErrorState(failure.errMessage));
      print(failure.errMessage);
    }, (data) {
      emit(DeleteAllNotificationsSuccessState(data));
    });
  }
}
