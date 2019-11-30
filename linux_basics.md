# Linux Giriş

Linux içerisinde kullanıcı programları bulunmayan C dilinde yazılmış bir işletim sistemi çekirdeğidir. Linux çekirdeğinin temel görevleri şunlardır: 

* Donanım kaynakları yönetmek (işlemci, RAM vs.)
* Kullanıcı programları için donanım bağımsız, taşınabilir API (sistem çağrıları) ve kütüphaneler sağlamak
* Dosya sistemleri için katman ve sürücüler
* Uygulamaların yönetimi

Linux çekirdeği birden çok işlemci mimarisini desteklemektedir. Ölçeklenebilirdir, hatta STM32 mikrokontrolcülerinde bile koşturulabilir.

Linux 1991 yılında Linus Torvalds tarafından "eğlence" amaçlı başlatılmış bir projedir. Bugün kendisininde dahil olduğu binden fazla katılımcı ile geliştirilmektedir. Linux bugün geldiği noktada çok geniş bir kullanım alanına sahiptir: Masaüstü bilgisayarlar, cep telefonları, akıllı TV, süper bilgisayarlar vs. ve tabii ki gömülü sistemler. 

Burada sık sık karıştırılan bir kavram olan Linux Dağıtımlarından da bahsetmek istiyorum. Linux dağıtımları; çekirdek ve ek yazılımlarla (ofis, masaüstü yöneticisi, paket yöneticisi vs.) bir araya getirilmesiyle oluşturulmuş tam bir işletim sistemidir. En bilinen dağıtımlar Debian, Ubuntu, Fedora, Pardus vs. olarak sayılabilir. 

Gömülü sistemler için de hazır Linux dağıtımlar bulunmakla beraber kaynak israfı gibi nedenlerle bizim tarafımızdan kullanılmayacaktır.

## Device Tree Kavramı

`Device Tree` donanımı tanımlayan özel bir binary dosyasıdır. Device tree kaynak dosyaları (dts) ve include dosyaları (dtsi) C diline benzer sözdizimine sahip bir dosyalardır. Kaynak dosyaları bir derleyici (DTC) ile derlenir ve binary (dtb) dosyaları oluşturulur. Binary dosyaları kernele U-Boot tarafından bildirilir. Kernel bu donanım dosyasına göre kurulum yapar ve çalışır.

Device Tree sistemi özellikle yüzlerce ARM cihazın ortaya çıkmasıyla gereksinim haline gelmiştir.

Device Tree hakkında detaylı bilgi için şu [döküman](https://elinux.org/images/f/f9/Petazzoni-device-tree-dummies_0.pdf) oldukça faydalıdır.

Kernel derleme ile aynı zamanda dtb dosyalarının da derlemesi yapılır. 
