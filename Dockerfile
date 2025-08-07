FROM amazoncorretto:21 

RUN yum install -y ca-certificates \
    && update-ca-trust force-enable \
    && yum update --security -y \
    && yum install -y libxml2 \
    && rpm -qi libxml2 \
    && yum install -y unzip \
    && yum clean all

ENTRYPOINT [ "ls" ]
