import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'qr_state.dart';

class QrCubit extends Cubit<QrState> {
  QrCubit() : super(QrInitial());

  void setQrResult(String result) => emit(QrData(result));
}
