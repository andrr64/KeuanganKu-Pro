import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';

String dateFormat(DateTime date, String format){
  return DateFormat(format).format(date);
}

DateTime convertTimeOfDayToDateTime(TimeOfDay timeOfDay) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
}

String formatTimeOfDay(TimeOfDay timeOfDay, {bool is24HourFormat = true}) {
  final dateTime = convertTimeOfDayToDateTime(timeOfDay);
  final format = is24HourFormat ? DateFormat('HH:mm') : DateFormat('hh:mm a');
  return format.format(dateTime);
}



// Fungsi untuk menggabungkan DateTime dan TimeOfDay menjadi string ISO
String combineDateTimeAndTimeOfDay(DateTime dateTime, TimeOfDay timeOfDay) {
  // Konversi TimeOfDay menjadi Duration (jumlah detik sejak tengah malam)
  final duration = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

  // Gabungkan tanggal dan durasi untuk mendapatkan DateTime yang tepat
  DateTime combinedDateTime = dateTime.add(duration);

  // Ubah zona waktu menjadi UTC
  combinedDateTime = combinedDateTime.toUtc();

  // Format DateTime ke dalam string ISO8601
  String isoFormatted = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(combinedDateTime);

  return isoFormatted;
}

// Fungsi untuk mengubah string ISO8601 menjadi DateTime
DateTime? parseIso8601String(String iso8601String) {
  // Gunakan try-catch untuk menangani kesalahan parsing
  try {
    // Gunakan parse dari DateTime untuk mengubah string menjadi DateTime
    DateTime dateTime = DateTime.parse(iso8601String);

    // Pastikan waktu yang dihasilkan sudah dalam UTC
    if (!iso8601String.endsWith('Z') && !iso8601String.endsWith('+00:00') && !iso8601String.endsWith('-00:00')) {
      // Jika tidak ada zona waktu yang ditambahkan, asumsikan waktu tersebut adalah UTC
      dateTime = dateTime.toUtc();
    }

    return dateTime;
  } catch (e) {
    // Tangkap dan cetak kesalahan jika parsing gagal
    return null;
  }
}