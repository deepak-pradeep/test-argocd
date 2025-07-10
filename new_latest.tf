locals {
  application_log_conf = <<-EOT
[INPUT]
    Name tail
    Tag application.*
    Exclude_Path /var/log/containers/cloudwatch-agent*, /var/log/containers/fluent-bit*, /var/log/containers/aws-node*, /var/log/containers/kube-proxy*
    Path /var/log/containers/*.log
    multiline.parser docker, cri
    DB /var/fluent-bit/state/flb_container.db
    Mem_Buf_Limit 50MB
    Skip_Long_Lines On
    Refresh_Interval 10
    Rotate_Wait 30
    storage.type filesystem
    Read_from_Head Off

[INPUT]
    Name tail
    Tag application.*
    Path /var/log/containers/fluent-bit*
    multiline.parser docker, cri
    DB /var/fluent-bit/state/flb_log.db
    Mem_Buf_Limit 5MB
    Skip_Long_Lines On
    Refresh_Interval 10
    Read_from_Head Off

[INPUT]
    Name tail
    Tag application.*
    Path /var/log/containers/cloudwatch-agent*
    multiline.parser docker, cri
    DB /var/fluent-bit/state/flb_cwagent.db
    Mem_Buf_Limit 5MB
    Skip_Long_Lines On
    Refresh_Interval 10
    Read_from_Head Off

[FILTER]
    Name kubernetes
    Match application.*
    Kube_URL https://kubernetes.default.svc:443
    Kube_Tag_Prefix application.var.log.containers.
    Merge_Log On
    Merge_Log_Key log_processed
    K8S-Logging.Parser On
    K8S-Logging.Exclude Off
    Labels Off
    Annotations Off
    Buffer_Size 0

# Split logs into stdout_logs and stderr_logs using stream key
[FILTER]
    Name                rewrite_tag
    Match               application.*
    Rule                $stream ^stderr$ stderr_logs false
    Rule                $stream ^stdout$ stdout_logs false

[OUTPUT]
    Name cloudwatch_logs
    Match stderr_logs
    region us-east-1
    log_group_name eks_test_logs
    log_stream_name $${HOSTNAME}-stderr-$${time}
    auto_create_group true
    extra_user_agent container-insights
    workers 1
    log_format json
    log_retention_days 7

[OUTPUT]
    Name kinesis_firehose
    Match stdout_logs
    region us-east-1
    Format json
    delivery_stream PUT-S3-p5K71
    workers 1
EOT
}