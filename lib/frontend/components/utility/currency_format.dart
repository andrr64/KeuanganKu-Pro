import 'package:intl/intl.dart';

String formatRupiah(double balance) {
  final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'IDR ', decimalDigits: 2);
  return formatter.format(balance);
}

String currencyFormat(double balance, {String? locale}){
  return formatRupiah(balance);
}