import 'package:flutter/material.dart';

void main() {
  runApp(const OgrenciBasvuruApp());
}

class OgrenciBasvuruApp extends StatelessWidget {
  const OgrenciBasvuruApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Öğrenci Form Uygulaması',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const BasvuruFormuEkrani(),
    );
  }
}

class BasvuruFormuEkrani extends StatefulWidget {
  const BasvuruFormuEkrani({super.key});

  @override
  State<BasvuruFormuEkrani> createState() => _BasvuruFormuEkraniState();
}

class _BasvuruFormuEkraniState extends State<BasvuruFormuEkrani> {
  final _formKey = GlobalKey<FormState>();

  // --- DEĞİŞKENLER (STATE) ---
  String? _adSoyad;
  String? _secilenSinif; 
  String _cinsiyet = 'Belirtilmedi'; 
  bool _robotikIlgi = false; 
  bool _bildirimAcik = true; 
  double _flutterSeviye = 1.0; 
  DateTime? _dogumTarihi; 
  TimeOfDay? _mulakatSaati; 

  final TextEditingController _aciklamaController = TextEditingController();

  final List<String> _siniflar = ['9. Sınıf', '10. Sınıf', '11. Sınıf', '12. Sınıf'];

  @override
  void dispose() {
    _aciklamaController.dispose();
    super.dispose();
  }

  Future<void> _tarihSec(BuildContext context) async {
    final DateTime? secilen = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (secilen != null && secilen != _dogumTarihi) {
      setState(() {
        _dogumTarihi = secilen;
      });
    }
  }

  Future<void> _saatSec(BuildContext context) async {
    final TimeOfDay? secilen = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (secilen != null && secilen != _mulakatSaati) {
      setState(() {
        _mulakatSaati = secilen;
      });
    }
  }

  void _formuGonder() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Başvuru Başarılı"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Ad Soyad: $_adSoyad"),
                Text("Sınıf: $_secilenSinif"),
                Text("Cinsiyet: $_cinsiyet"),
                Text("Robotik İlgi: ${_robotikIlgi ? 'Var' : 'Yok'}"),
                Text("Flutter Seviye: ${_flutterSeviye.toInt()}"),
                Text("Doğum Tarihi: ${_dogumTarihi != null ? "${_dogumTarihi!.day}/${_dogumTarihi!.month}/${_dogumTarihi!.year}" : "Seçilmedi"}"),
                Text("Saat: ${_mulakatSaati?.format(context) ?? "Seçilmedi"}"),
                const Divider(),
                Text("Not: ${_aciklamaController.text}"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Tamam"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Öğrenci Kulüp Başvurusu"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // --- TEXTFORMFIELD (Ad Soyad) ---
              const Text("Kişisel Bilgiler", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Adınız Soyadınız",
                  hintText: "Örn: Ali Yılmaz",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen adınızı giriniz';
                  }
                  if (value.length < 3) {
                    return 'İsim en az 3 harfli olmalıdır';
                  }
                  return null;
                },
                onSaved: (value) {
                  _adSoyad = value;
                },
              ),
              const SizedBox(height: 15),

              // --- DROPDOWNBUTTONFORMFIELD (Sınıf Seçimi) ---
              // DÜZELTME 1: 'value' yerine 'initialValue' kullanıldı.
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Sınıfınızı Seçin",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
                initialValue: _secilenSinif, 
                items: _siniflar.map((String sinif) {
                  return DropdownMenuItem(value: sinif, child: Text(sinif));
                }).toList(),
                onChanged: (String? yeniDeger) {
                  setState(() {
                    _secilenSinif = yeniDeger;
                  });
                },
                validator: (value) => value == null ? 'Lütfen sınıf seçiniz' : null,
              ),
              const SizedBox(height: 15),

              // --- RADIO GROUP (Cinsiyet) ---
              // DÜZELTME 2: RadioListTile'lar 'RadioGroup' içine alındı.
              const Text("Cinsiyet", style: TextStyle(fontWeight: FontWeight.bold)),
              
              RadioGroup<String>(
                // Önceki hatayı gidermek için 'value' yerine 'groupValue' kullanıyoruz.
                groupValue: _cinsiyet,
                onChanged: (value) {
                  setState(() {
                    if (value != null) _cinsiyet = value;
                  });
                },
                child: Row(
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text("Kız"),
                        value: "Kız",
                        // Artık burada groupValue veya onChanged YOK.
                        // Bunları üstteki RadioGroup yönetiyor.
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title: const Text("Erkek"),
                        value: "Erkek",
                        // Artık burada groupValue veya onChanged YOK.
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),

              // --- SLIDER (Bilgi Seviyesi) ---
              Text("Flutter Bilgi Seviyeniz: ${_flutterSeviye.toInt()}", style: const TextStyle(fontWeight: FontWeight.bold)),
              Slider(
                value: _flutterSeviye,
                min: 0,
                max: 10,
                divisions: 10,
                label: _flutterSeviye.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _flutterSeviye = value;
                  });
                },
              ),
              const Divider(),

              // --- CHECKBOX (İlgi Alanı) ---
              CheckboxListTile(
                title: const Text("Robotik Kodlama"),
                subtitle: const Text("Arduino/Raspberry Pi ilgim var"),
                value: _robotikIlgi,
                onChanged: (bool? value) {
                  setState(() {
                    _robotikIlgi = value ?? false;
                  });
                },
              ),

              // --- SWITCH (Bildirim) ---
              SwitchListTile(
                title: const Text("Bildirimler"),
                subtitle: const Text("Gelişmelerden haberdar et"),
                value: _bildirimAcik,
                onChanged: (bool value) {
                  setState(() {
                    _bildirimAcik = value;
                  });
                },
              ),
              const Divider(),

              // --- DATE & TIME PICKER (Tarih ve Saat) ---
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _tarihSec(context),
                      icon: const Icon(Icons.calendar_month),
                      label: Text(_dogumTarihi == null ? "Tarih Seç" : "${_dogumTarihi!.day}/${_dogumTarihi!.month}/${_dogumTarihi!.year}"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _saatSec(context),
                      icon: const Icon(Icons.access_time),
                      label: Text(_mulakatSaati == null ? "Saat Seç" : _mulakatSaati!.format(context)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // --- TEXTFIELD (Normal Metin Alanı) ---
              TextField(
                controller: _aciklamaController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Ek Açıklamalar (Opsiyonel)",
                  hintText: "Belirtmek istediğiniz diğer detaylar...",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // --- KAYDET BUTONU ---
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _formuGonder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("BAŞVURUYU TAMAMLA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}