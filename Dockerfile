FROM java:8-jdk
MAINTAINER docker@reecerobinson.co.nz
ENV APACHE_SPARK_VERSION=1.4.1
RUN curl -s http://d3kbcqa49mib13.cloudfront.net/spark-1.4.1-bin-hadoop2.6.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-1.4.1-bin-hadoop2.6 spark
ENV SPARK_HOME /usr/local/spark
ENV PATH $PATH:$SPARK_HOME/bin
 
RUN     apt-get update && \
	apt-get install -y gdebi && \
        apt-get install -y npm && \
        apt-get install -y libc6 libc6-dev libc-dev udev && \
        apt-get install -y python-dev && \
        apt-get install -y python-pip && \
        apt-get install -y libfreetype6 libfreetype6-dev zlib1g-dev && \
        apt-get install -y python-matplotlib && \
        pip install py4j && \
        pip install numpy && \
        pip install "ipython[All]" && \
        apt-get clean
 
RUN git clone https://github.com/ReeceRobinson/incubator-zeppelin.git
RUN     wget http://ppa.launchpad.net/natecarlson/maven3/ubuntu/pool/main/m/maven3/maven3_3.2.1-0~ppa1_all.deb && \
        gdebi -n maven3_3.2.1-0~ppa1_all.deb && \
        ln -s /usr/share/maven3/bin/mvn /usr/bin/mvn && \
        rm maven3_3.2.1-0~ppa1_all.deb 

RUN     git config --global url.https://github.com/.insteadOf git://github.com/
RUN 	cd incubator-zeppelin && mvn package -Pspark-1.4 -Dhadoop.version=2.6.0 -Phadoop-2.6 -Pyarn -DskipTests
 
RUN     mkdir -p /incubator-zeppelin/logs
RUN     mkdir -p /incubator-zeppelin/run
VOLUME ["/incubator-zeppelin/notebook", "/incubator-zeppelin/logs"]
EXPOSE 8080 8081

CMD ["/incubator-zeppelin/bin/zeppelin.sh"]
