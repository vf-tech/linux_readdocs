# Gömülü Linux Nedir?

> Gömülü sistem, bilgisayarın kendisini kontrol eden cihaz tarafından içerildiği özel amaçlı bir sistemdir. Genel maksatlı, örneğin kişisel bilgisayar gibi bir bilgisayardan farklı olarak, gömülü bir sistem kendisi için önceden özel olarak tanımlanmış görevleri yerine getirir. Sistem belirli bir amaca yönelik olduğu için tasarım mühendisleri ürünün boyutunu ve maliyetini azaltarak sistemi uygunlaştırabilirler. Gömülü sistemler genellikle büyük miktarlarda üretildiği için maliyetin düşürülmesinden elde edilecek kazanç, milyonlarca ürünün katları olarak elde edilebilir.

[Kaynak](http://www.wikizero.biz/index.php?q=aHR0cHM6Ly90ci53aWtpcGVkaWEub3JnL3dpa2kvRyVDMyVCNm0lQzMlQkNsJUMzJUJDX3Npc3RlbQ"alt")

Yukarıdaki paragrafa bağlı olarak Gömülü Linux ise belli amaca yönelik program(lar) koşturan elektronik bir sistemdir. Bu nedenle Gömülü Linux sistemi normal PC dağıtımlarından(Ubuntu, Fedora vs.) farklı olarak sadece amacına yönelik programları içermelidir, örneğin bir fabrikada kayıt işlemlerini takip eden bir sistemde torrent istemcisine gerek yoktur. 

Aynı zamanda tekrar yukarıda bulunan paragrafa atıfla sistemin olabildiğince ucuz olması gereklidir bu nedenle *işi yapabilecek kadar* sistemin hafif olması büyük olasılıkla maliyetleri azaltacaktır. 

Gömlü Linux ile masaüstü linux sistemlerin karşılaştırması aşağıdaki linklerden incelenebilir.

http://embeddedcraft.org/embedlinuxdesktoplinux.html

http://embeddedcraft.org/embeddedlinux.html

# Gömülü Linux Mimarisi

Linux bir sistem temelde 4 parçadan oluşur:

* Bootloader
* Kernel 
* Dosya Sistemi (RootFS)
* Kullanıcı Alanı (userspace) Dosyaları

Kullanıcı alanı dosyaları RootFS içerisinde bulunur ancak bunlar proje kapsamında geliştirdiğimiz programlar, scriptler olduğu için ayrıca bildirmek istedim.

//TODO # Neden Gömülü Linux Kullanılmalı?

# Motivasyon ve Amaç

Gömülü Linux dünyası şuan çeşitli **_PI** boardların işgali altında. Bu durum donanımsal açıdan baktığınız zaman mükemmel, S3C2416'lı boardların hayal olduğu günlerden Kadıköy'den RasPI alabildiğiniz günlere gelebilmek.

Ancak bu boardlar hazır dağıtımlarla geliyor ve işin sadece uygulama geliştirme kısmını insanlara bırakıyor. Yanlış anlaşılmasın bu durum birçok kişinin gömülü linux dünyasına geçişini kolaylaştırıyor ancak endüstriyelleşme aşamasında maalesef ciddi bir israf söz konusu. Aynı zamanda bu durum oluşan hatalara karşıda geliştiricileri savunmasız bırakıyor, bir nevi enerjiyi verdiğinizden uygulamaya kadar olan kısım tam bir **kapalı kutu**. 

Tabii bu kutunun huyunu suyunu bilmeden yapılan geliştirme ne kadar sağlıklı olur, takdiri size bırakıyorum.

Son olarak hazır dağıtımlara olan bağımlılık can sıkıcı olabilir örneğin [armbian](https://www.armbian.com/) mükemmel işler çıkarıyor ancak Allwinner A20 bazı kartlara desteği kesmiş ve TFT sürücü desteği yok (yada ben bulamadım).

Bu kitabın amacı ise; bu kapalı kutu hakkında bilgi sağlamak ve farkındalık sağlamak, hazır dağıtımlardan sizi kurtarmak :) 

# Yöntem ve Araçlar

Bu kitapta Gömülü Linux sistemini oluşturmak için sadece Linux komut satırı (shell, kabuk) kullanılacaktır. Bootloader ve Kernel imajları için özel bir araç kullanılmayacaktır ancak RootFS (kök dosya sistemi) oluşturmak için [Buildroot](https://buildroot.org) kullanılacaktır. 

Kernel ve Bootloader için yaptığımız değişiklikler gömülü linux sistemlerinin de-facto versiyon kontrol standardı olan [git](https://git-scm.com/) yaması (patch) olarak saklanacaktır. Bunun nedenlerini ve sonuçlarını kitapta ilerleyince daha iyi anlayacaksınız. 

Geliştirme için kullanılacak sistem **Ubuntu 16.04 LTS** olacaktır. Hazır bir sanal makinayı ileriki günlerde yüklemeyi düşünüyorum. Tavsiyem ise daha hafif ve Windows tip arayüzü olması nedeniyle [Linux Mint 18.3](https://linuxmint.com/). Bu sistemler Debian'dan türetildiği için aralarında bizim komut satırında yapacağımız işlemler için fark bulunmamaktadır. 

Geliştirme yapacağımız kart ise Beaglebone Black (BBB) olacaktır. Her ne kadar yapacağımız işler elektronik kart bağımsız olarak hedeflenmiş olsa da kartlarda çıkan ufak farklılıklar (örneğin RasPI'de ki bootloader) başlangıç aşamasında canınızı sıkmaması için BBB tavsiyemdir. 

# Öneriler

* Komut satırından her işinizi yapmaya çalışın, eliniz mouse'a gitmesin :)
* Komut satırına hakim olmayanlar için Bootlin'in [dökümanına](https://bootlin.com/doc/legacy/command-line/command_memento.pdf) göz atın.
* Yaptığınız tüm aşamaları çıktıları ile birlikte **anlaşılır** bir biçimde not edin. 
* Sanal Makina yerine sabit bir sistem kurulması performans ve olası hataları engelleyeceği için tavsiye edilmektedir.
* İlk seferde zaten çalışmayacaktır, bu nedenle [code hard](https://24t9d72kcs873my15o9hr1pu-wpengine.netdna-ssl.com/wp-content/uploads/2014/12/06-programming-coding-is-hell.png)...

# Kaynaklar

İnternette bir dolu örnek ve kaynak bulunmaktadır ancak benim yararlandığım ve fayda gördüğüm kaynakların bir kısmı şu şekildedir:

* Nazım Koç Hoca'nın [websitesi](http://www.ucanlinux.com/) ve [kitabı](https://www.idefix.com/kitap/gomulu-linux-sistemleri/nazim-koc/egitim-basvuru/bilgisayar/urunno=0000000374677)
* İngilizce bilenler için [Bootlin](https://bootlin.com/) 

# Lisans

Bu websitesinde yayınlanan herşey ile ilgili lisans : [Creative Commons Attribution - Share Alike 3.0](https://creativecommons.org/licenses/by-sa/3.0/)

Lisansla ilgili kurallara göz atarsanız sevinirim.
