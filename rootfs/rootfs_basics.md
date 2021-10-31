# RootFS Nedir?

Unix-benzer işletim sistemlerinde tüm dosyaların olduğu dosya sistemine kök dosya sistemi (rootfs) denilir. MS-DOS tabanlı işletim sistemlerinde tek bir kök-dosya sistemi yoktur, her bir depolama birimi veya bölümünün kendine ait kök klasörlere ayrılmıştır. Gözlemime göre bu fark Windows tabanlı kullanıcıların geçiş aşamasında yaşadığı en büyük uyum sorunlarından birisidir.

RootFS (kök-dosya sistemi) `/` ile gösterilir ve en üst kademedir. Bu seviyenin altında standart olarak kabul edebileceğimiz klasörler bulunmaktadır. ( /bin , /dev , /mnt , /home gibi )

RootFS içerisinde çalışma anında kullanacağımız programlar, açılış scriptleri, kütüphaneler vs. belli bir hiyerarşide bulunmalıdır. Bir RootFS sistemini yüzlerce belki binlerce dosya oluşturabilir.

Örneğin sisteminizde bir adet rar dosya açıcı ve müzik programı olduğunu ve bu iki programın kullanması gereken ortak bir kütüphanenin olduğunu düşünelim. Bu durumda iki programın kütüphanenin farklı versiyonları ile çalışması/çalışmaması gibi uyumluluk sorunları ortaya çıkabilir.

Bu nedenlerle RootFS oluşturmak oldukça karmaşık bir işlem haline gelebilmektedir.

[Kaynak](http://www.linfo.org/root_directory.html)

## RootFS Oluşturma Yöntemleri

RootFS oluşturmak için temelde 3 adet yöntem vardır:

1. Manuel Oluşturulmuş Dağıtımlar
2. Hazır Dağıtımlar
3. Derleme Tabanlı Dağıtımlar

### Manuel Yöntem

Manuel yöntem işin inceliklerini öğrenmek için en iyi yöntemdir. Bilgisayarınızda boş bir klasör açarak adım adım içerisinde ilerleyebilirsiniz. Qemu emülatörü ile de hızlı denemeler yapabilirsiniz. Bu konuda Türkçe kaynak olarak şu kaynakları öneririm:

1. http://www.ucanlinux.com/eski-blog-yaz%C4%B1lar%C4%B1
2. [Gömülü Linux Sistemleri Kitabı](https://www.idefix.com/kitap/gomulu-linux-sistemleri/nazim-koc/egitim-basvuru/bilgisayar/urunno=0000000374677)
3. https://demirten.gitbooks.io/gomulu-linux/content/

Şuan için bu kaynakta Manuel dosya sistemi oluşturma konusu incelenmeyecektir.

### Hazır Dağıtımlar

ARM tabanlı işlemciler için Ubuntu gibi bazı hazır dağıtımlar mevcuttur. Örneğin Debian periyodik güncellenen dağıtımlar yayınlamaktadır. Bu dağıtımların avantajı ARM için hazır bulunan repoları sayesinde program bulma/derleme/uyumluluk sorunları giderme işlerinden sizi kurtarmaktadır. Bazı geliştirme kart üreticileri kendi hazır dağıtımlarını (genellikle Debian'dan türetilmiş) yayınlamaktadır. Ancak bu sistemler genellikle oldukça şişkindir ve kaynak kullanımını yüksektir. Bu nedenle gömülü sistemler için pek ideal değildir.

### Derleme Tabanlı Dağıtımlar

Derleme tabanlı sistemler ise belirlediğimiz yönergeler çerçevesinde bizim için RootFS oluştururlar. Bu sayede oldukça küçük veya karmaşık sistemler oluşturabiliriz. 

Derleme tabanlı sistemler temelde bize kendi ekosistemlerinde bulunan paketleri sunarlar. Eğer bir paketin sistemimizde olmasını istiyorsak onu aktif ederiz ve seçtiğimiz paket internetten indirilir, işlemcimize yönelik derlemesini yapılır sistemin oluşturduğu RootFS içerisine gerekli yan dosyaları ile birlikte kopyalanır. Derleyici sistem ilgili paketin sorun çıkarmayacak versiyonu ile çalışır bu sayede paketler arası uyumluluk gözetilmiş olur.

Gömlülü Linux için en popüler iki adet sistem şunlardır: [Yocto](https://www.yoctoproject.org/) ve [Buildroot](https://buildroot.org/)

#### Yocto Projesi

Yocto Linux Foundatation başta olmak üzere Texas Instruments, NXP gibi büyük oyuncularında destek verdiği gömülü linux sistemleri üretmeyi amaçlayan açık kaynak kod bir projedir.

Yocto ile gömülü linux sistemindeki tüm parçalar (bootloader, kernel, rootfs) üretilebilir, konfigüre edilebilir. 

Ancak Yocto projesi *nedense* oldukça hantaldır ayrıca konfigüre etmek için *nedense* bir arayüzü yoktur, üstelik karmaşık diyebileceğimiz bir yapısı vardır. Hantallığına örnek vermek için Beaglebone-Black için kurmak istediğim en basit sistemin derlenmesi i7+SSD diske sahip masaüstü bir makina da yaklaşık 4 saat sürmüştür.

Bu nedenlerle biraz Yocto projesine mesafeliyim.

#### Buildroot Projesi

Buildroot için kısaca Yocto'nun basitleştirilmiş hali diyebiliriz. Elbette bu iki sistemin işleyişleri birbirinden oldukça farklıdır. Buildroot açık kaynak bir projedir, topluluk tabanlı destek ile yürütülmektedir. 

Buildroot projesinin başında Peter Korsgaard vardır ancak bu aşamada [Bootlin](https://bootlin.com/) firmasından bahsetmek gerekir. Bootlin Linux üzerine eğitim/danışmanlık veren ve Linux dünyasında hatırı sayılır geliştirmede bulunan bir firmadır ve websitelerinde oldukça faydalı eğitim dökümanları bulunmaktadır.

Buildroot Yocto gibi gömülü linux sistemindeki tüm parçaları (bootloader, kernel, rootfs) üretilebilir, konfigüre edilebilir.

Buildroot konfigürasyon için kernel ve u-boot kullanımında alıştığımız `menuconfig` yapısını kullanır. Bu sayede oldukça basit bir yönetim sunmaktadır.

Yocto ile hız açısından karşılaştırmak istersek Beaglebone-Black için tüm derleme 1 saatin altında olabilmektedir. 

Bundan sonraki aşamalarda Buildroot ile RootFS oluşturma anlatılacaktır.



