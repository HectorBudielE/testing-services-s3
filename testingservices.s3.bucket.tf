resource "aws_s3_bucket" "testingservices" {
  bucket = "ha-${var.environment}-testing-services-${var.aws_region}"
  acl = "private"
  force_destroy = "false"
  acceleration_status = "Enabled"
  versioning {
    enabled = true
  }

  # versioning lifecycle rules.
  # TODO most are incorrectly defined and need to be updated.
  lifecycle_rule {
    "id" = "pricing-lodgingRates"
    prefix = "lodgingRates/"
    enabled = true
    noncurrent_version_transition {
      days = 180
      storage_class = "STANDARD_IA"
    }
    noncurrent_version_transition {
      days = 365
      storage_class = "GLACIER"
    }
  }

  lifecycle_rule {
    "id" = "pricing-lodgingTaxes"
    prefix = "lodgingTaxes/"
    enabled = true
    noncurrent_version_transition {
      days = 180
      storage_class = "STANDARD_IA"
    }
    noncurrent_version_transition {
      days = 365
      storage_class = "GLACIER"
    }
  }
  lifecycle_rule {
    "id" = "pricing-lodgingStayCollectedFees"
    prefix = "lodgingStayCollectedFees/"
    enabled = true
    noncurrent_version_transition {
      days = 180
      storage_class = "STANDARD_IA"
    }
    noncurrent_version_transition {
      days = 365
      storage_class = "GLACIER"
    }
  }
  lifecycle_rule {
    "id" = "pricing-lengthOfStayRates-psrTesting"
    prefix = "LengthOfStayRatesPsrTest/"
    enabled = true
    expiration {
      days = 1
    }
  }

  lifecycle_rule {
    "id" = "pricing-LengthOfStayRates-expiration"
    prefix = "LengthOfStayRates/"
    enabled = "${var.los_lifecycle_deletion_enabled}"

    tags {
      "booked" = "false"
    }
    noncurrent_version_expiration {
      days = "${var.los_lifecycle_deletion_time_days}"
    }
  }

  tags {
    Name = "${var.aws_region}-${var.environment}-testing-services"
    Env = "${var.environment}"
    Owner = "${var.owner}"
    Service = "${var.service}"
    Product = "${var.product}"
    Portfolio = "${var.portfolio}"
    AssetProtectionLevel = "99"
    Brand = "HomeAway"
    ComponentInfo = "adf44460-3976-4ace-8d08-194ede5a2342"
  }
}

resource "aws_s3_bucket_policy" "testing-services-bucket-policy" {
  bucket = "${aws_s3_bucket.pricingservices.bucket}"

  policy = <<POLICY
{
    "Id": "S3-Console-Auto-Gen-Policy-1564684705355",
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "S3PolicyStmt-DO-NOT-MODIFY-1564684705355",
            "Effect": "Allow",
            "Principal": {
                "Service": "s3.amazonaws.com"
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::${aws_s3_bucket.testingservices.bucket}/*"
            ],
            "Condition": {
                "ArnLike": {
                    "aws:SourceArn": [
                        "arn:aws:s3:::${aws_s3_bucket.testingservices.bucket}"
                    ]
                },
                "StringEquals": {
                    "aws:SourceAccount": [
                        "${var.aws_account_id}"
                    ],
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}
