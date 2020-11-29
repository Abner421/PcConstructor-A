class Modelo {
  String _uid;
  String _almacenamiento;
  String _coolerGabinete;
  String _cpuCooler;
  String _fuentePoder;
  String _gabinete;
  String _graficas;
  String _motherboard;
  String _procesador;
  String _ram;

  Modelo(
      this._uid,
      this._almacenamiento,
      this._coolerGabinete,
      this._cpuCooler,
      this._fuentePoder,
      this._gabinete,
      this._graficas,
      this._motherboard,
      this._procesador,
      this._ram);

  Modelo.map(dynamic obj) {
    this._uid = obj['uid'];
    this._almacenamiento = obj['almacenamiento'];
    this._coolerGabinete = obj['coolerGabinete'];
    this._cpuCooler = obj['cpuCooler'];
    this._fuentePoder = obj['fuentePoder'];
    this._gabinete = obj['gabinete'];
    this._graficas = obj['graficas'];
    this._motherboard = obj['motherboard'];
    this._procesador = obj['procesador'];
    this._ram = obj['ram'];
  }

  String get uid => _uid;
  String get almacenamiento => _almacenamiento;
  String get coolerGabinete => _coolerGabinete;
  String get cpuCooler => _cpuCooler;
  String get fuentePoder => _fuentePoder;
  String get gabinete => _gabinete;
  String get graficas => _graficas;
  String get motherboard => _motherboard;
  String get procesador => _procesador;
  String get ram => _ram;

  Map<String, dynamic> toMap() {
    return {
      'uid': _uid,
      'almacenamiento': _almacenamiento,
      'coolerGabinete': _coolerGabinete,
      'cpuCooler': _cpuCooler,
      'fuentePoder': _fuentePoder,
      'gabinete': _gabinete,
      'graficas': _graficas,
      'motherboard': _motherboard,
      'procesador': _procesador,
      'ram': _ram
    };
  }

  Modelo.fromMap(Map<String, dynamic> map) {
    this._uid = map['uid'];
    this._almacenamiento = map['almacenamiento'];
    this._coolerGabinete = map['coolerGabinete'];
    this._cpuCooler = map['cpuCooler'];
    this._fuentePoder = map['fuentePoder'];
    this._gabinete = map['gabinete'];
    this._graficas = map['graficas'];
    this._motherboard = map['motherboard'];
    this._procesador = map['procesador'];
    this._ram = map['ram'];
  }
}
