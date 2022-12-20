
//Regular Expressions (Düzenli İfadeler) kelimesinin kısaltması olan regex, e-posta adresi, tarih, telefon numarası gibi
//kullanıcı tarafından girilen ve belirli bir düzen içeren girdilerin kontrolünün sağlanması ve herhangi bir kod, metin içerisinde istenilen yazı
//veya kod parçasının aranıp bulunmasını, yönetilmesini sağlayan kendine ait söz dizimi olan bir yapıdır.

String validationEmail = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

String validationName = r'^[a-z A-Z]+$';

String baseUrl = 'https://fakestoreapi.com';//bu siteden Api olarak malzemeleri alacz bu sabit kalacz ve istedigmiz category/bilgi yaninda ekleyebilirz

String arabic = 'Arabic 🇸🇦';//flagEmoji sitesinde adiyi kopyalayip buraya string olarak yazmak yeterli olack
String english = 'English 🇬🇧';//bu degerleri kullanark text icinde flaglari gosterebilirz
String france = 'French 🇫🇷';
String turkey='Turkish 🇹🇷';

String ara = 'ar';
String ene = 'en';
String frf = 'fr';
String trt='tr';