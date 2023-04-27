class Weather {
  final String regular;

  Weather({
    required this.regular,
  });

  factory Weather.fromMap({required Map data}) {
    return Weather(
      regular: data['results'][0]['regular'],
    );
  }
}
