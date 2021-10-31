# Toolchain ve Çapraz Derleyici(Cross-Compile) Kavramları

> Çapraz Derleyici üzerinde çalıştığı platformdan farklı olan platformlar için yürütülebilen kodlar üreten derleyicidir. Böyle bir araç, erişiminizde olmayan bir platform için kod derlenmesi gerektiğinde ya da böyle bir platform üzerinde kod derleme işleminin yapılmasının imkânsız olduğu (gömülü sistemlerde olduğu gibi, mikrokontrolörler minimum bellek ile çalıştığı için derleme imkânsız olur) durumlarda faydalı olabilir.

Kaynak: [Wikipedia](http://www.wikizero.biz/index.php?q=aHR0cHM6Ly90ci53aWtpcGVkaWEub3JnL3dpa2kvJUMzJTg3YXByYXpfZGVybGV5aWNpbGVy)

Cross-Compile (CC) aslında mikrokontrolcülerle uğraşan insanların hergün yaptığı bir işlem. Temelde x86 tabanlı makinalarda çalıştığımızdan ve gömülü sistemler farklı tabanlarda (arm, MIPS, risc-V) olduğundan CC işlemine gerek duyarız. Eğer hedef makina ile aynı tabanda uygulama geliştiriyorsak çapraz derleme değil sadece derleme işlemi yaparız. 

İnternette direk olarak gömülü sistem üzerinde derleme yapan örnekler mevcut ancak hem gömülü sistemlerin daha zayıf makinalar olması hem de gömülü sistemlerde çalışma durumunda kullanılmayacak gereksiz paketlerin kurulması nedeniyle ben böyle yöntemlere sıcak bakmıyorum.

Çapraz derleme ile ilgili daha başka yöntemlerde mevcut ancak bu kitapta bunları işlemeyi düşünmüyorum.

Peki Toolchain nedir? 

> Toolchain, bilgisayar yazılımı dilinde Araç Zinciri, bir ürün (genellikle başka bir bilgisayar programı veya sistem programları) oluşturmak için kullanılan programlama araçlarının setidir. Araçlar bir zincir içerisinde kullanılabilir, böylece her bir aracın çıktısı bir sonrakinin girdisi olmuş olur. Fakat bu terim yaygın bir şekilde, bağlı geliştirim araçlarının herhangi bir setine işaret eder.

Kaynak: [Wikipedia](http://www.wikizero.biz/index.php?q=aHR0cHM6Ly90ci53aWtpcGVkaWEub3JnL3dpa2kvVG9vbGNoYWlu)

Özetle bizim **cross-compile** yapmak için **toolchain'e** ihtiyacımız var.

# Toolchain Kurulumu

Günümüzde ARM mimari için toolchain genellikle Linaro'nun sağladığı toolchain kullanılmaktadır. Linaro ARM mimarisi için açık-kaynak yazılımlar (Linux Kernel, GCC Toolchain vs.) üreten bir şirkettir. Linaro ST, Samsung, Quallcomm, TI, Alibaba vs. gibi onlarca firma tarafından desteklenmektedir. Bu nedenle bir bakıma ARM için gerekli olan toolchain konusunda endüstri standardı durumundadır. 

Geliştirme yapacağımız sisteme Linaro toolchain kurmak için birkaç seçeneğimiz var. Benim önerim eğer başlangıç olarak `Adım-2` ile yürümek şimdilik yeterlidir. 

### 1. Ubuntu Repo'dan kurmak
~~~~
sudo apt-get install gcc-arm-linux-gnueabihf
~~~~

Açıkçası bu yöntemi kurduğu toolchain versiyonun farklı tarihlerde farklı olacağı nedeniyle pek tercih etmiyorum. 

### 2. Linaro websitesinden indirmek.

Linaro derlenmiş haldeki toolchain'i https://releases.linaro.org/components/toolchain/binaries/ adresinde yayınlamaktadır. Burada istediğiniz bir versiyonu indirip kullanabiliriz. 

Örneğin 7.3'ü kurmak için öncelikle indirip `toolchain` klasörüne açalım.
~~~~
cd workspace/download
wget https://releases.linaro.org/components/toolchain/binaries/7.3-2018.05/arm-linux-gnueabihf/gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf.tar.xz
tar xvf gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf.tar.xz -C /opt/workspace/sdk/
~~~~

Bu noktadan sonra yapılması gereken toolchain'i `PATH` içine eklemek. Bunun için aşağıdaki komutu çalıştırmamız gerekir. 
~~~~
export CC=/opt/workspace/sdk/gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-
~~~~
Kontrol etmek için aşağıdaki komut kullanılır.
~~~~
{CC}gcc --version
~~~~ 

Çıktı şu şekilde ise işler yolunda demektir.

>arm-linux-gnueabihf-gcc (Linaro GCC 7.3-2018.05) 7.3.1 20180425 [linaro-7.3-2018.05 revision d29120a424ecfbc167ef90065c0eeb7f91977701]  
Copyright (C) 2017 Free Software Foundation, Inc.  
This is free software; see the source for copying conditions.  
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


Bu yöntemde her yeni terminal açtığımızda komutu tekrarlamamız gerekmektedir. Bunun yerine toolchain'i `PATH` içine otomatik olarak ekleyebiliriz. Ancak bu yöntemde farklı toolchainler (örneğin aynı makinada hem Linaro hem de CodeSourcery gerekiyorsa) kullanmanız gerektiğinde işler biraz karışabiliyor, bu nedenle ben her terminal açılışında `PATH` içine manuel olarak ekliyorum.

Eğer yine de otomatik olarak yapmak isterseniz.

~~~
nano ~/.bashrc
~~~
son satıra aşağıdaki bölüm eklenir ve dosya kaydedilir. 

    PATH=/opt/workspace/sdk/arm/bin:$PATH
    export PATH

Doğru ayarlandığını kontrol etmek için mevcut terminal kapatılır ve yeni terminal açılır, aşağıdaki komut ile kontrol edilir.
~~~
which arm-linux-gnueabihf-gcc
~~~

###  3. TI veya üreticinin verdiği toolchaini kurmak

TI Processor-SDK adı altında belirli aralıklarla U-Boot, Linux, Toolchain ve çeşitli yazılımları yayınlamaktadır.

AM335x serisi için [Processor SDK](http://www.ti.com/tool/PROCESSOR-SDK-AM335X)

Bu kitabı yazarken en son versiyon 5.03'tü. [Download Linki](http://software-dl.ti.com/processor-sdk-linux/esd/AM335X/latest/exports/ti-processor-sdk-linux-am335x-evm-05.03.00.07-Linux-x86-Install.bin)

TI SDK'nin avantajı üretici tarafından yayınlandığından (TI forumlarında zaten ilk sordukları soru SDK versiyonu) daha rahat destek bulabiliyorsunuz ve kısmen TI destekli bir platformda geliştirme yapıyorsunuz.

SDK kurulumu şu şekildedir:

~~~
cd /opt/workspace/download
wget http://software-dl.ti.com/processor-sdk-linux/esd/AM335X/latest/exports/ti-processor-sdk-linux-am335x-evm-05.03.00.07-Linux-x86-Install.bin
chmod +x ti-processor-sdk-linux-am335x-evm-05.03.00.07-Linux-x86-Install.bin
./ti-processor-sdk-linux-am335x-evm-05.03.00.07-Linux-x86-Install.bin
~~~

SDK'yi `/opt/workspace/ti-processor-sdk-linux-am335x-evm-05.03.00.07` klasörüne kuracağız.

Processor SDK içindeki Toolchain `ti-processor-sdk-linux-am335x-evm-05.03.00.07/linux-devkit/sysroots/x86_64-arago-linux/usr/bin` klasörü altındadır. Bir önceki adımda `PATH` içine toolchain ekleme açıklandığı için tekrarlanmayacaktır.

### 4. Buildroot Toolchain'i kullanmak.

Açıkçası benim tercihim bu yöntem. Çünkü RootFS'i ve geliştireceğimiz uygulamaları Buildroot'un toolchain ile derleyeceğiz. Bu nedenle Linux ve U-Boot'un da bu toolchain ile derlenmesini tercih ediyorum. 

Şu aşamada Buildroot'u bilmediğimiz varsayarsak; sadece basit bir derleme yapacağız ve onun çıktısı olan SDK'yı kullanacağız. 

[Buildroot ile Basit Derleme](../boot/uboot_compile.md) başlığında bu konu anlatılmaktadır.
