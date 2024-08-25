import 'package:bloc/bloc.dart';
import 'package:pocket_guide/industry/models/industry_type_enum.dart';

/// {@template process_cubit}
/// Holds current process information
/// This is a temporary solution until GoRouter v5 is updated
/// {@endtemplate}
class InitialLayoutCubit extends Cubit<IndustryType> {
  /// {@macro process_cubit}
  InitialLayoutCubit() : super(IndustryType.all[0]);

  /// Updates current state with a certain industry type
  void setIndustryType(IndustryType industryType) => emit(industryType);

  /// Provides the next industry on the lost
  /// if greater than list length, returns the first one
  // TODO(dennis): refactor this
  IndustryType getNextIndustryType() {
    final index = IndustryType.all.indexOf(state);
    final nextIndex = index + 1;

    if (nextIndex >= IndustryType.all.length) {
      return IndustryType.all[0];
    }
    return IndustryType.all[nextIndex];
  }

  /// Toogles current product
  void toogleIndustryLayout([int? index]) {
    late final IndustryType industryType;
    if (index == null) {
      industryType = getNextIndustryType();
    } else {
      industryType = IndustryType.all[index];
    }
    emit(industryType);
  }
}
