#!/bin/bash
# Sistemi güncelle
dnf upgrade -y

# Apache ve gerekli paketleri kur
dnf install -y httpd wget php-fpm php-mysqli php-json php php-devel

# Apache başlat ve açılışta otomatik çalıştır
systemctl start httpd
systemctl enable httpd

# EC2 kullanıcı izinlerini güncelle
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www && find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;

# Web sitesi dosyalarını S3’ten çek (bucket adını kendi bucket’ına göre değiştir)
aws s3 sync s3://my-first-bucket-name /var/www/html/ --delete
