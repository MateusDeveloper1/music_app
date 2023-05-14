import 'package:get/get.dart';

mixin ScreenLoadingErrorMixin {
  final RxBool _isloading = true.obs;

  final RxnString _error = RxnString();

  void setLoadingToTrue() => _isloading.value = true;

  void setLoadingToFalse() => _isloading.value = false;

  void setError(String? errorString) => _error.value = errorString;

  bool get getIsLoading => _isloading.value;

  String? get getError => _error.value;
}
