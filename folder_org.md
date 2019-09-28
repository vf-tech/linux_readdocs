# Klasör Organizasyonu 

Bu kitapta takip edilecek bir klasör organizasyonu şu şekildedir: 

>* workspace
>    * doc
>    * uboot
>    * linux
>    * buildroot
>    * download
>    * sdk

`sdk` klasörü toolchain(ler)i koyacağımız, `doc` klasörü internetten indirdiğimiz dökümanları koymak için kullanacağımız klasörlerdir. Diğer klasörler isimlerinden zaten anlaşılıyor. 

Bu klasör grubu `/opt` klasörü altındadır. `/opt` klasörünün genelde yetkisi `root` kullanıcısındadır. Bunu değiştirmemiz gereklidir.

~~~~
sudo mkdir /opt/workspace/
sudo chown $USER:$USER /opt/workspace/
cd /opt/workspace
~~~~

sudo apt install sed make binutils gcc g++ bash patch git gzip bzip2 perl tar cpio python unzip rsync wget libncurses-dev
