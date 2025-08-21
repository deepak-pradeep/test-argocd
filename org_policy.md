name: organizations/YOUR_ORG_ID/customConstraints/custom.blockSmbPorts
resource_types:
- compute.googleapis.com/Firewall
method_types:
- CREATE
- UPDATE
condition: "resource.direction.matches('INGRESS') && resource.sourceRanges.contains('0.0.0.0/0') && (resource.allowed.containsFirewallPort('tcp', '139') || resource.allowed.containsFirewallPort('tcp', '445'))"
action_type: DENY
display_name: Block firewall rules allowing ingress SMB ports from public
description: Prevents creation or update of ingress firewall rules that allow TCP ports 139 or 445 from any source (0.0.0.0/0).
