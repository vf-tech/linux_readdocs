# U-Boot Giriş

U-Boot Linux çekirdeği gibi kendine özel bir konsolu ve komutları vardır. Bu komutlar ve belirli parametreleri kullanarak U-Boot'u yönlendiririz.(çekirdeği nerede arayacak, çekirdeğe hangi parametreleri verecek vs. gibi)

## U-Boot Komutları

U-Boot komutlarının bir kısmı için [link](https://www.denx.de/wiki/U-Bootdoc/BasicCommandSet)

Önemli olan U-Boot komutları şunlardır(kullanımları aşağıda verilmemiştir) : 

* `bootz` , `bootm` Belli bir RAM adresindeki zImage formatındaki kerneli yürütür.
* `fatload` DOS dosya sistemine sahip cihazdan dosyayı RAM adresine yükler.  
* `ext2load` EXT2 dosya sistemine sahip cihazdan dosyasını RAM adresine yükler.
* `ping` ağ testi için kullanılır.
* `tftp` ağdan dosya çekip RAM'e yüklemek için kullanılır.
* `dhcp` ağda bulunan DHCP serverdan IP almak için kullanılır.
* `mmc` eMMC, SD-Kart donanımlarına yönelik komutları içerir.
* `help` Varolan komutları listeler.

U-Boot komut seti bizim yapacağımız derlemeye göre değişkenlik gösterebilir. Örneğin FAT dosya sistemi ile ilgili komutları derleme esnasında yapacağımız konfigürasyona göre kapatıp/açabiliriz.

## U-Boot Ortam Değişkenleri

U-Boot parametre ve komut bütününe ortam değişkenleri (environment variables) denir. 

U-Boot ortam değişkenlerini derleme öncesinde, derleme sonrasında harici bir dosya ile veya komut satırından ayarlayabiliriz. Komut satırından yapılan değişiklikler eğer hedef cihazda U-Boot üzerinden kaydetme yapılıyorsa varsa kalıcı olarak saklanabilir. Ancak bu durum üretim için pek pratik değildir.

Ortam değişkenlerinin derleme öncesinde değiştirilmesi daha sonra işlenecektir.

Ortam değişkenleri ile ilgili U-Boot komutları şunlardır:

* `printenv` tüm ortam değişkenlerini listeler
* `setenv` RAM'de ortam değişkeni varsa değiştirir yoksa ekler.
* `saveenv` RAM'de olan ortam değişkenlerini kaydeder. 

Harici ortam değişkeni dosyası olarak çeşitli formatlar var ancak bizim sistemimiz için `uEnv.txt` dosyası kullanılacaktır. U-Boot `uEnv.txt` dosyasını bulursa mevcut ortam değişkenlerini ezer. 

Bazı önemli ortam değişkenleri şunlardır:

* `bootcmd` U-Boot'un boot amaçlı çalıştıracağı komuttur.
* `bootargs` U-Boot'un kernele ileteceği parametreleri tutar.
* `ipaddr` Cihazın IP Adresi
* `serverip` tftpboot komutu için gerekli olan server IP adresi

Ortam değişkenleri ufak scriptler olabilirler, bu sayede çeşitli U-Boot komutları tek bir ortam değişkeni ile tanımlanabilir.

## Örnek : uEnv.txt 

~~~
loadaddr=0x82000000
fdtaddr=0x88000000
arg=setenv bootargs console=ttyO0,115200n8 root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait
image=load mmc 0:1 ${loadaddr} uImage ;
fdt=load mmc 0:1 ${fdtaddr} am335x-bonegreen.dtb ;
uenvcmd=run arg;load image;load fdt;bootm ${loadaddr} - ${fdtaddr};
~~~

`loadaddr` --> RAM adresi.

`fdtaddr` --> RAM adresi.  

`arg` --> `setenv` komutu ile `bootargs` değişkeni; konsol ttyO0 (UART0) ve rootfs'in mmcblk0p2 içinde ext4 biçiminde olacak şekilde ayarlanır. `bootargs` içindeki parametreler kernele bildirilir.  

`image` --> mmc0:1 (sd-kart boot bölümü) bölümünden uImage dosyasını okur ve loadaddr adresine yükler.  

`fdt` --> mmc0:1 (sd-kart boot bölümü) bölümünden am335x-bonegreen.dtb dosyasını okur ve fdtaddr adresine yükler.  

`uenvcmd` --> U-Boot'un yürüteceği ilk komuttur. Örneğimizde görüldüğü üzere U-Boot sırasıyla `arg` , `image` , `fdt` komutlarını ve son olarak `bootm` komutunu yürütecektir.   
