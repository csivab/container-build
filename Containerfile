# Use the httpd-parent image as base
FROM quay.io/redhattraining/httpd-parent

EXPOSE 8080

LABEL io.k8s.display-name="A child container" \
      io.k8s.description="Apache container" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="Apache, httpd"

RUN sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf && \
    sed -i "s/#ServerName www.example.com/ServerName 0.0.0.0:8080/g" /etc/httpd/conf/httpd.conf && \
    chgrp -R 0 /var/log/httpd /var/run/httpd && \
    chmod -R g=u /var/log/httpd /var/run/httpd 
ONBUILD COPY src/ /var/www/html/
USER ex288-sa

 
