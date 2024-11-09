resource "aws_route53_zone" "brainbuilds_zone" {
  # (resource arguments)
  name = "brainbuilds.net.au"
  force_destroy = false

}


resource "aws_route53_record" "example_a_record" {
  zone_id = aws_route53_zone.brainbuilds_zone.zone_id
  name    = "example.brainbuilds.net.au"
  type    = "A"
  ttl     = "300"
  records = ["8.8.8.8"]
}
