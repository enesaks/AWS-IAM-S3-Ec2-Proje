# AWS IAM-S3-EC2 Mini Proje 🚀

Bu proje kapsamında, basit bir web sitesini AWS üzerinde farklı servisleri bir araya getirerek yayına aldım.  
Amacım sadece bir web sitesi kurmak değil, aynı zamanda AWS’nin temel servislerini (IAM, S3, EC2, Auto Scaling, Load Balancer) bir senaryo üzerinde deneyimlemekti.  
Böylece **cloud üzerinde yetkilendirme, depolama, sunucu yönetimi ve otomatik ölçekleme** mantığını uygulamalı olarak öğrendim.  

---

## 🎯 Projenin Amacı
- **IAM (Identity and Access Management)** kullanarak güvenlikli bir şekilde roller ve yetkiler oluşturmak.  
- **S3 (Simple Storage Service)** ile statik içerik barındırmak, bucket logging özelliğini deneyimlemek.  
- **EC2 (Elastic Compute Cloud)** üzerinde Apache web sunucusu kurarak dinamik içerik sunmak.  
- **Auto Scaling Group** ile trafik/CPU yüküne göre sistemin otomatik büyüyüp küçülmesini sağlamak.  
- **Application Load Balancer (ALB)** ile yükü birden fazla instance’a dağıtarak yüksek erişilebilirlik sağlamak.  

Sonuç olarak:  
➡️ Herkesin erişebileceği, yük altında otomatik ölçeklenen, güvenli ve modern bir web uygulaması ortamı kurmak.  

---

## 🔧 Yapılan Adımlar

1. **IAM Role Oluşturma**  
   - EC2 instance’ların sadece S3’ten **okuma izni** olacak şekilde özel bir role tanımlandı.

2. **S3 Bucket’lar**  
   - AWS CLI üzerinden iki bucket açıldı.  
   - 1. bucket: Website hosting için.  
   - 2. bucket: Access log’ların yazılması için.

3. **Server Access Logging**  
   - 1. bucket üzerinde logging aktif edildi, loglar 2. bucket’a yazıldı.

4. **Web Sitesi Dosyaları**  
   - `https://github.com/aytitech/onepage.git` reposu indirildi.  
   - `.git` klasörü hariç olmak üzere içerik 1. bucket’a sync edildi.  
   - Static Website Hosting aktif edilerek dış dünyaya açıldı.

5. **Launch Template**  
   - Amazon Linux 2023, `t2.micro` instance için template oluşturuldu.  
   - Bootstrap (user data) script ile:  
     - Apache kuruldu.  
     - Her açılışta Apache servisinin çalışması sağlandı.  
     - 1. bucket’taki site dosyaları `/var/www/html` dizinine sync edildi.

6. **Auto Scaling Group**  
   - Launch template kullanılarak min 2, max 5 instance’lık ASG kuruldu.  
   - CPU kullanımı %60 üzerine çıkınca scale-out olacak şekilde ayarlandı.  

7. **Application Load Balancer**  
   - İnternete açık (internet-facing) bir ALB oluşturuldu.  
   - Target group ile Auto Scaling Group’taki instance’lar bağlandı.  
   - ALB DNS üzerinden siteye erişim test edildi.

8. **Test**  
   - Site ALB üzerinden çalıştı.  
   - `stress` aracı ile CPU yükü artırılınca Auto Scaling Group yeni instance ekledi.  
   - Yeni instance ALB tarafından healthy olarak işaretlendi ve trafik dağıtımı başladı.  

---

### Proje Fotoğrafları
<img width="3420" height="1951" alt="Image" src="https://github.com/user-attachments/assets/c2caf5fc-6238-41db-9c82-fb71389a2821" />
<img width="3420" height="1951" alt="Image" src="https://github.com/user-attachments/assets/7604dd62-2f39-402c-9b90-f435a2b9ebd4" />
<img width="3420" height="1951" alt="Image" src="https://github.com/user-attachments/assets/750d3a23-7eca-439d-ae31-888006f0cb11" />
