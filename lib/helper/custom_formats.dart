import 'dart:math';

import 'package:cryptlib_2_0/cryptlib_2_0.dart';
import 'package:get/get.dart';

class CustomFormats {
  String formatElapsedTime(time) {
    var currentTime = DateTime.now().toUtc();
    var convertTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(time)).toUtc();

    if (currentTime.isBefore(convertTime)) {
      final temp = currentTime;
      currentTime = convertTime;
      convertTime = temp;
    }

    final elapsedDuration = currentTime.difference(convertTime);

    if (elapsedDuration.inDays >= 365) {
      final years = (elapsedDuration.inDays / 365).floor();
      return '$years${years > 1 ? ' ${'years'.tr}' : ' ${'y'.tr}'}';
    } else if (elapsedDuration.inDays >= 30) {
      final months = (elapsedDuration.inDays / 30.44).floor();
      return '$months${months > 1 ? ' ${'months'.tr}' : ' ${'month'.tr}'}';
    } else if (elapsedDuration.inDays >= 7) {
      final weeks = (elapsedDuration.inDays / 7).floor();
      return '$weeks${' ${'w'.tr}'}';
    } else if (elapsedDuration.inDays > 0) {
      return '${elapsedDuration.inDays}${' ${'d'.tr}'}';
    } else if (elapsedDuration.inHours > 0) {
      return '${elapsedDuration.inHours} ${'h'.tr}';
    } else if (elapsedDuration.inMinutes > 0) {
      return '${elapsedDuration.inMinutes} ${'m'.tr}';
    } else {
      return '${elapsedDuration.inSeconds} ${'s'.tr}';
    }
  }

  String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length > 3) {
      String firstPart = phoneNumber.substring(0, phoneNumber.length - 2);
      String asterisks = "X" * 2;

      return firstPart + asterisks;
    } else {
      return '';
    }
  }

  List<String> generateHashtags(String word) {
    RegExp exp = RegExp(r'#\w+');
    Iterable<Match> matches = exp.allMatches(word);
    List<String> hashtags = [];
    for (Match match in matches) {
      hashtags.add(match.group(0)!);
    }
    return hashtags;
  }

  List<String> generateTagsCustom(String word) {
    word = word.removeAllWhitespace.toLowerCase();
    List<String> substrings = [];
    substrings.addAll(generateSubstrings(word));
    substrings.addAll(generateRandomTags(word));
    return substrings;
  }

  String encryptText(
    String text,
    String key,
  ) {
    return CryptLib.instance
        .encryptPlainTextWithRandomIV(text, 'auto${key}guide');
  }

  String decryptText(
    String text,
    String key,
  ) {
    return CryptLib.instance
        .decryptCipherTextWithRandomIV(text, 'auto${key}guide');
  }

  List<String> generateSubstrings(String word) {
    word = word.removeAllWhitespace.toLowerCase();
    List<String> substrings = [];
    for (int i = 1; i <= word.length; i++) {
      substrings.add(word.substring(0, i));
    }
    return substrings;
  }

  List<String> generateRandomTags(String word) {
    word = word.removeAllWhitespace.toLowerCase();
    List<String> tags = [];
    Random random = Random();
    for (int i = 0; i < 10; i++) {
      String tag = '';

      for (int j = 0; j < word.length; j++) {
        if (random.nextBool()) {
          tag += word[j];
        }
      }
      tags.add(tag);
    }
    return tags;
  }
}
