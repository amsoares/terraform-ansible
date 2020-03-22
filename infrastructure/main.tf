provider "aws" {
  region  = var.region
  profile = var.profile
}

resource "aws_wafregional_web_acl" "pc_waf_acl" {
  name = "pc_waf_acl"
  metric_name = "pcwafacl"

  default_action {
    type = "ALLOW"
  }

  rule {
    action {
      type = "BLOCK"
    }

    priority = 0
    rule_id  = aws_wafregional_rule.pc_detect_blacklisted_ips.id
    type     = "REGULAR"
  }
}

resource "aws_wafregional_rule" "pc_detect_blacklisted_ips" {
  name        = "pc_blacklisted_ips"
  metric_name = "pcblacklistedips"

  predicate {
    data_id = aws_wafregional_ipset.pc_blacklisted_ips.id
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_ipset" "pc_blacklisted_ips" {
  name = "pc_ipset"
  dynamic "ip_set_descriptor" {
    for_each = [for ip_set in var.blacklisted_ips : {
      type  = ip_set.type
      value = ip_set.value
    }]
    content {
      type  = ip_set_descriptor.value.type
      value = ip_set_descriptor.value.value
    }
  }
}