import 'package:bloc/bloc.dart';
// TODO(someone): badge number for bottom nav bar
class BadgeNotificationsCubit extends Cubit<int> {
  BadgeNotificationsCubit() : super(0);

  void clearNotifications() => emit(0);
}
