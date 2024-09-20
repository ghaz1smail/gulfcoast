class AppData {
  final RegExp isArabic =
      RegExp(r'[\u0600-\u06FF\u0750-\u077F\uFB50-\uFDFF\uFE70-\uFEFF]');

  final String apiKey = 'AIzaSyCrrGtlbGKHL9R2s1ZFsoE0NtoBRXrQyFw';

  List<String> carsStatus = [
    'at_terminal',
    'new',
    'booked',
    'loaded',
    'shipped',
    'delivered',
    'released_to_client',
    'unloaded'
  ];
}
