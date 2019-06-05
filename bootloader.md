# Bootloader ve U-Boot

Bootloader, bilgisayar yada gömülü bir sistem ilk enerji verildiğinde çalışan uygulamalardır. Bu programların temel amacı işletim sistemi için CPU ve çevrebirimlerin hazırlanmasıdır. 

PC(x86) makinalar için kullanılan bootloader bilindiği üzere BIOS'tur. Gömülü Linux sistemlerini genelde ARM mikroişlemciler kullanılmaktadır ve en yaygın olarak kullanılan bootloader U-Boot'tur.

U-Boot Denx firması tarafından geliştirilen ücretsiz genel amaçlı bir bootloaderdır. U-Boot bir çok mimariyi desteklemektedirler(ARM, MIPS, x86 vs.) U-Boot günümüzde özellikle gömülü linux sistemleri için *de-facto* standart haline gelmiştir. 

U-Boot dökümantasyonu şu adreste bulunabilir. http://www.denx.de/wiki/U-Boot/Documentation

# Boot Prosesi

Bu bölümde kitapta kullanacağımız Beagleboard Black kartının işlemcisi olan AM335x serisinin boot prosesi incelenecektir. Örnek olarak QSPI Flash'tan Kernel imajı yüklenecektir, boot prosesi ise şu şekildedir:

* CPU içerisinde ilk açılışta herhangi bir yazılım yoktur, bu nedenle CPU içerisine donanımsal olarak gömülmüş olan ROM Bootloader(RBL) CPU tarafından yürütülmeye başlanır.
* RBL çevrebirimleri tarar ve bunların içerisinde İkinci Bootloader'ı (SPL) yükler.
* SPL RAM, QSPI vs. gibi en temel çevrebirimleri kurar. SPL çeşitli isimlerde UBL, XLoader, MLO  vs. gibi adlandırılmaktadır.
* SPL QSPI'dan U-Boot bootloader dosyasını RAM'e yükler.
* U-Boot diğer çevrebirimleri kurar(Ethernet, USB vs.)
* U-Boot Kernel imajını RAM'e yükler.

Peki yukarıdaki süreçte neden SPL'e ihtiyaç vardır? Bunun cevabı için AM335x datasheetine bakmak gereklidir. AM335x'te dahili olarak bulunan RAM'in boyutu U-Boot'u karşılayacak seviyede değildir, bu nedenle harici RAM'in kurulması gereklidir ancak harici RAM karttan karta farklılık göstereceğinden RBL tarafından kurulamaz.

Bu nedenle ara bir çözüm olarak dahili RAM'den koşabilecek ve U-Boot'u harici RAM'e yükleyecek daha küçük bir bootloader olarak SPL kullanılmaktadır. SPL oluşturmak için ayrı bir derleme sürecine gerek yoktur, U-Boot bize SPL seçeneğini bize sunmaktadır. 

U-Boot'un yüklenmesi yerine SPL'den direk olarak Kernel imajını yüklemekte mümkündür.

>TI işlemciler için boot prosesi ile ilgili detaylı [kaynak](https://training.ti.com/system/files/docs/sitara_boot_camp_03_giving_linux_the_boot.pptx)
