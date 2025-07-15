part of 'qr_cubit.dart';

@immutable
sealed class QrState {}

final class QrInitial extends QrState {}

final class QrData extends QrState {
  final String message;
  QrData(this.message);
}
