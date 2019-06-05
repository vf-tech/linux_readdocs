# U-Boot Derleme

U-Boot indirmek için iki adet kaynağımız var. Denx veya BBB işlemcisinin üreticisi olan Texas Instruments (TI) websitelerinden. 

TI; U-Boot ve Linux için kaynaklarından aldığı snapshotların üzerine kendi işlemcileri için ek geliştirmeler koyarak dağıtımını yapmaktadır. Esas hedefimiz **endüstriyel** olduğu için ben TI'nin websitesinden U-Boot ve Linux kaynak kodlarını kullanmayı tercih ediyorum. 

Biz yine de Denx'den indirmenin komutunu verelim.
~~~~
git clone git://git.denx.de/u-boot.git
~~~~

Peki TI'dan nasıl indireceğiz? Bunun için iki yol var. 

1. TI Processor SDK 
2. git.ti.com