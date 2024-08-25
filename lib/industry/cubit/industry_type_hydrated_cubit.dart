import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pocket_guide/industry/models/initial_layout_model.dart';

class InitialLayoutHydratedCubit extends HydratedCubit<InitialLayoutModel> {
  // InitialLayoutHydratedCubit(super.state);
  InitialLayoutHydratedCubit() : super(InitialLayoutModel.initialInitialLayout);

  /// Updates current state with a certain industry type
  void updateIndustryTypeIndex(int industryTypeIndex) =>
      emit(state.copyWith(industryTypeIndex: industryTypeIndex));
  void updateButtonClickState() =>
      emit(state.copyWith(buttonClickState: !state.buttonClickState));
  @override
  InitialLayoutModel? fromJson(Map<String, dynamic> json) =>
      InitialLayoutModel.fromMap(json);

  @override
  Map<String, dynamic>? toJson(InitialLayoutModel state) => state.toMap();
}
