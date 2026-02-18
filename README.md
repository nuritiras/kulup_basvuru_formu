# 📝 Öğrenci Kulüp Başvuru Formu (Flutter)

Bu proje, Flutter öğrenenler için **Form Yönetimi**, **Kullanıcı Girişleri** ve **Veri Doğrulama (Validation)** işlemlerini tek bir çatı altında gösteren kapsamlı bir eğitim uygulamasıdır.

![Proje Görseli](<img width="569" height="1090" alt="Ekran Resmi 2026-02-18 09 10 20" src="https://github.com/user-attachments/assets/bb58850c-33ff-4c9f-9525-7855359f1e3e" />)
<img width="569" height="1090" alt="Ekran Resmi 2026-02-18 09 10 20" src="https://github.com/user-attachments/assets/e659dae0-446e-438b-8383-2d8e0149e1f8" />

## 🚀 Proje Hakkında

Bu uygulama, bir öğrencinin okul kulübüne başvururken doldurması gereken alanları simüle eder. Amaç, Flutter'ın temel giriş Widget'larının birbiriyle nasıl uyumlu çalıştığını ve `GlobalKey` kullanarak form verilerinin nasıl yönetildiğini göstermektir.

## 🛠 Kullanılan Teknolojiler ve Widget'lar

Bu projede aşağıdaki Flutter yapıları kullanılmıştır:

* **Form & GlobalKey:** Tüm formun durumunu (state) yönetmek ve doğrulamak için.
* **TextFormField:** İsim soyisim gibi metin girişleri ve boş bırakılamaz kontrolü.
* **DropdownButtonFormField:** Sınıf seçimi için açılır liste.
* **RadioListTile & RadioGroup Mantığı:** Cinsiyet seçimi için tekli seçim yapısı.
* **CheckboxListTile:** İlgi alanları için çoklu seçim kutusu.
* **SwitchListTile:** Bildirim ayarları için açma/kapama anahtarı.
* **Slider:** Bilgi seviyesini ayarlamak için kaydırma çubuğu.
* **DatePicker & TimePicker:** Doğum tarihi ve mülakat saati seçimi.
* **AlertDialog:** Form başarıyla gönderildiğinde çıkan özet penceresi.

## 📦 Kurulum

Projeyi kendi bilgisayarınızda (veya Pardus ETAP üzerinde) çalıştırmak için şu adımları izleyin:

1.  **Projeyi Klonlayın:**
    ```bash
    git clone [https://github.com/KULLANICI_ADINIZ/kulup-basvuru-formu.git](https://github.com/KULLANICI_ADINIZ/kulup-basvuru-formu.git)
    ```

2.  **Proje Dizinine Girin:**
    ```bash
    cd kulup-basvuru-formu
    ```

3.  **Paketleri Yükleyin:**
    ```bash
    flutter pub get
    ```

4.  **Uygulamayı Çalıştırın:**
    ```bash
    flutter run
    # Linux masaüstü için:
    flutter run -d linux
    ```

## 📚 Öğrenciler İçin Notlar

Kodları incelerken şu noktalara dikkat edin:
* `_formKey.currentState!.validate()` komutu, form içindeki tüm `validator` fonksiyonlarını tetikler.
* `setState(() {})` kullanımı, kullanıcı bir seçim yaptığında (örneğin Checkbox'a tıkladığında) ekranın güncellenmesini sağlar.
* Tarih ve Saat seçimi `Future` (gelecek) zamanlı işlemlerdir, bu yüzden `async/await` yapısı kullanılmıştır.

## 👨‍💻 Geliştirici

**Nuri TIRAŞ**
* Web: [nuritiras.com.tr](https://nuritiras.com.tr)
* Blog: [pardusflutter.blogspot.com](https://pardusflutter.blogspot.com)

## 📄 Lisans

Bu proje eğitim amaçlıdır ve MIT lisansı ile lisanslanmıştır. Dilediğiniz gibi kullanabilir, değiştirebilir ve geliştirebilirsiniz.
