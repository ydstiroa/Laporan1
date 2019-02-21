# Laporan Pratikum Modul 1

### No.1 
Anda diminta tolong oleh teman anda untuk mengembalikan filenya yang telah dienkripsi oleh seseorang menggunakan bash script, file yang dimaksud adalah nature.zip. Karena terlalu mudah kalian memberikan syarat akan membuka seluruh file tersebut jika pukul 14:14 pada tanggal 14 Februari atau hari tersebut adalah hari jumat pada bulan Februari.
Hint: Base64, Hexdump

Jawab :

hal pertama yang dillakukan adalah membuat file scriptnya  pada folder nature yang sudah diekstrak sebelumnya
		
	nano en.sh

setelah itu isikan en.sh dengan script sebagai berikut: 
[Source Code](/en.sh)    
		
	#!/bin/bash
	z=”1”
	for i in /home/yudhis/Documents/nature-1/nature/*.jpg
	do
	    base64 -d $i | xxd -r >> /home/yudhis/Documents/Foto/$z.jpg
	z=$(($z+1))
	done
		
Script tersebut bertujuan untuk men decode setiap gambar yang tidak bisa dibuka agar bisa di bukan kembali.

untuk mencoba apakah script tersebut jalan maka bisa di cek dengan melakakukan
	
	bash en.sh

  ![soal1](/images/soal1.png)

sehabis membuat scipt tersebut. Lalu buka (crontab -e) dan setting jadwal sesuai dengan yang diminta
	
	14 14 14 2 5 /bin/bash /home/yudhis/Documents/en.sh >> /home/yudhis/Documents/en.log 2>&1

### No.2
Anda merupakan pegawai magang pada sebuah perusahaan retail, dan anda diminta
untuk memberikan laporan berdasarkan file WA_Sales_Products_2012-14.csv.
Laporan yang diminta berupa:
	*Tentukan negara dengan penjualan(quantity) terbanyak pada tahun 2012.
	*Tentukan tiga product line yang memberikan penjualan(quantity) terbanyak pada soal poin a.
	*Tentukan tiga product yang memberikan penjualan(quantity) terbanyak berdasarkan tiga product line yang didapatkan pada soal poin b.

Jawab : 

Pastikan file dari soal diketahui keberadaannya oleh terminal, ketikkan syntax awk ini pada terminal : 

	awk -F ',' '{if($7=="2012") a[$1]+=$10} END {for(x in a)print a[x] " "x}' WA_Sales_Products_2012-14.csv | sort -n | tail -1 | awk -F, '{print $2}'

![soal2](/images/soal2.png)

Ubah syntax pada no a menjadi 

	awk -F ',' '{if(($7=="2012") && ($1=="United States")) a[$4]+=$10} END {for(x in a)print a[x] " " x}' WA_Sales_Products_2012-14.csv | sort -n | tail -3 | awk -F, '{print $2}'

![soal2a](/images/soal2a.png)

Gunakan syntax berikut ini

	awk -F, '{if($1=="United States" && $7=="2012" && ($4=="Personal Accessories" || $4=="Camping Equipment" || $4=="Outdoor Protection")) a[$6]+=$10;} END {for(x in a)print a[x] "," x}' WA_Sales_Products_2012-14.csv | sort -n -r | head -n 3 | awk -F, '{print $2}'


![soal2b](/images/no2c.png)
	
### No.3
Membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 12 karakter yang terdapat huruf besar, kecil, dan angka. File berekstensi .txt dengan syarat disimpan dalam bentuk password1.txt, file selanjutnya tidak boleh sama dengan file sebelumnya dan urutan yang sudah terhapus harus terbuat lagi jika dijalankan, dan pastinya password tidak boleh sama.

Jawab :
Hal pertama yang harus dilakukan adalah membuat scriptnya
	nano no3.sh
setelah itu isi file tersebut dengan script berikut ini
	[Source Code](/no3.sh)
	
	#! /bin/bash
	getpass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1)

	pass="password"
	no=1
	while test -e "$pass$no.txt"; 
	  do  
	    no=$((no+1))
	 done
	fname="$pass$no.txt"
	echo "$getpass" > $fname

Script tersebut bertujuan untuk membuat file file.txt bernama password[z].txt dimana z akan terus bertambah selama script dijalankan.

jika sudah maka cek apakah script tersebut jalan dengan melakukan bash maka hasilnya akan seperti berikut.
	![no3](/images/no3.png)

## No.4
Lakukan backup file syslog setiap jam dengan format nama file “jam:menit tanggal-
bulan-tahun”. Isi dari file backup terenkripsi dengan konversi huruf (string
manipulation) yang disesuaikan dengan jam dilakukannya backup misalkan sebagai
berikut:

a. Huruf b adalah alfabet kedua, sedangkan saat ini waktu menunjukkan
pukul 12, sehingga huruf b diganti dengan huruf alfabet yang memiliki
urutan ke 12+2 = 14.
b. Hasilnya huruf b menjadi huruf n karena huruf n adalah huruf ke
empat belas, dan seterusnya.
c. setelah huruf z akan kembali ke huruf a
d. Backup file syslog setiap jam.
e. dan buatkan juga bash script untuk dekripsinya.

Jawab : 

Buatlah file script yang berisi seperti dibawah ini, sebelumnya copy file syslog terlebih dahulu dari direktori var/log pada direktori script anda agar tidak terhalang oleh permission denied.

![no4](/images/no4.png)

Kemudian ketikkan crontab -e dan tambahkan syntax seperti dibawah ini

	@hourly /bin/bash /home/najaslanardo/Documents/Sisop/modul1/soal4.sh >> /home/najaslanardo/Documents/Sisop/modul1/soal4.log 2>&1

Dengan demikian isi dari file syslog akan di backup dan di enkripsi seperti permintaan pada soal setiap satu jam. Berikut file hasil enkripsinya

![n04](/images/no4(2).png)

## No.5
Buatlah sebuah script bash untuk menyimpan record dalam syslog yang memenuhi
kriteria berikut:

* Tidak mengandung string “sudo”, tetapi mengandung string “cron”, serta buatlah pencarian stringnya tidak bersifat case sensitive, sehingga huruf kapital atau tidak, tidak menjadi masalah.

* Jumlah field (number of field) pada baris tersebut berjumlah kurang dari 13.

* Masukkan record tadi ke dalam file logs yang berada pada direktori /home/[user]/modul1.

* Jalankan script tadi setiap 6 menit dari menit ke 2 hingga 30, contoh 13:02, 13:08, 13:14, dst.

Jawab :

* Tidak mengandung string sudo

		$0 !~ /sudo/
* Jumlah number of field kurang dari 13 

		$0 ~ /cron/
* Masukkan record tadi ke file log pada direktori 

		 /home/yudhis/modul1/syslogno5.log
* Setting pada crontab 

		2-30/6 * * * *

Script utuhnya adalah
	[Source Code](/soal5.sh)
	
	# !/bin/bash
	
	awk '{if ($0 ~ /cron/ && $0 !~ /sudo/ && NF < 13) print $0}' /var/log/syslog >> /home/yudhis/modul1/syslogno5.log
	
![no5](/images/no5.png)

