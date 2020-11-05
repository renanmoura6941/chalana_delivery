import 'dart:io';

class FotoModelo {
   String url;
   String uuid;
   bool selecionado;
   File local;

   FotoModelo({this.local, this.selecionado = false, this.url, this.uuid});

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'uuid': uuid,
    };
  }
   @override
  String toString() {
    return "Imagem: id: $uuid, url: $url, local: $local,selecionada: $selecionado";
  }
}
