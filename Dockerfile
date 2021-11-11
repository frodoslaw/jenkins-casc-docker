FROM jenkins/jenkins:2.320-alpine-jdk8

ENV TZT "Europe/Warsaw"
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false -Dhudson.security.csrf.GlobalCrumbIssuerConfiguration.DISABLE_CSRF_PROTECTION=true"
ENV JENKINS_ADMIN_ID admin
ENV JENKINS_ADMIN_PASSWORD password

USER root

RUN apk update \
    && apk add tzdata ca-certificates\
    && rm -rf /var/cache/apk/* \
    && cp /usr/share/zoneinfo/Europe/Warsaw /etc/localtime \
    && echo ${TZT}>/etc/timezone \
    && date



COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt


COPY casc.yaml /var/jenkins_home/casc.yaml

ENV CASC_JENKINS_CONFIG "/var/jenkins_home/casc.yaml"
