#!/bin/bash
# İki bucket oluştur
aws s3 mb s3://my-first-bucket-name
aws s3 mb s3://my-second-log-bucket

# Birinci bucket’a access logging aç
aws s3api put-bucket-logging \
  --bucket my-first-bucket-name \
  --bucket-logging-status '{
        "LoggingEnabled": {
            "TargetBucket": "my-second-log-bucket",
            "TargetPrefix": "logs/"
        }
    }'

# Repo içeriğini indir (önce local makineye clone)
git clone https://github.com/aytitech/onepage.git
cd onepage

# İçeriği .git klasörü hariç S3’e kopyala
aws s3 sync . s3://my-first-bucket-name --exclude ".git/*"
