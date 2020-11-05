class FotoModelo {
  final String url;
  final String uuid;

  const FotoModelo({this.url, this.uuid});

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'uuid': uuid,
    };
  }
}
