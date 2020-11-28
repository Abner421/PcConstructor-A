class Procesador {
  String _marca;
  String _modelo;
  String _nucleos;
  String _hilos;
  String _socket;
  String _velBase;
  String _velTurbo;

  Procesador(this._marca, this._modelo, this._nucleos, this._hilos,
      this._socket, this._velBase, this._velTurbo);

  Procesador.map(dynamic obj){
    this._marca = obj['marca'];
    this._modelo = obj['modelo'];
    this._nucleos = obj['nucleos'];
    this._hilos = obj['hilos'];
    this._socket = obj['socket'];
    this._velBase = obj['velBase'];
    this._velTurbo = obj['velTurbo'];
  }

  String get marca => _marca;
  String get modelo => _modelo;
  String get nucleos => _nucleos;
  String get hilos => _hilos;
  String get socket => _socket;
  String get velBase => _velBase;
  String get velTurbo => _velTurbo;

  Map<String, dynamic> toMap() {
    return {
      'marca': _marca,
      'modelo': _modelo,
      'nucleos': _nucleos,
      'hilos': _hilos,
      'socket': _socket,
      'velBase': _velBase,
      'velTurbo': _velTurbo
    };
  }

  Procesador.fromMap(Map<String, dynamic> map){
    this._marca = map['marca'];
    this._modelo = map['modelo'];
    this._nucleos = map['nucleos'];
    this._hilos = map['hilos'];
    this._socket = map['socket'];
    this._velBase = map['velBase'];
    this._velTurbo = map['velTurbo'];
  }

}