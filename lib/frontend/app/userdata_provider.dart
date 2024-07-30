import 'package:hooks_riverpod/hooks_riverpod.dart';

final globalUserdataProvider = NotifierProvider<UserdataProvider, dynamic>(UserdataProvider.new);

class UserdataProvider extends Notifier {
  String name = 'Wait...';

  bool init = false;

  @override
  build() {
    readData();
  }

  void readData() async {
    // TODO: implement read data function
    name = 'Andreas';
  }
}