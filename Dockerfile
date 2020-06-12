FROM ubuntu

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install wget -y
RUN wget http://www.islonline.com/system/installer_latest_linux64 -O isl_installer
RUN chmod +x isl_installer
RUN ./isl_installer

WORKDIR /opt/confproxy
RUN rm /etc/init.d/confproxy -rf

RUN rm root_bind_tcp -rf
RUN rm setting_trustednet -rf
RUN echo "0.0.0.0/0" >> setting_trustednet

RUN echo "while true; do" >> start
RUN echo "./confproxy_server" >> start
RUN echo "sleep 1" >> start
RUN echo "done" >> start
RUN chmod +x ./start

RUN mkdir /data
RUN mv actions /data/actions
RUN mv bulk_files /data/bulk_files
RUN mv crashdumps /data/crashdumps
RUN mv db /data/db
RUN mv downloads /data/downloads
RUN mv messages /data/messages
RUN mv objects /data/objects
RUN mv tasks /data/tasks
RUN mv translations /data/translations


RUN ln -s /data/actions actions
RUN ln -s /data/bulk_files bulk_files
RUN ln -s /data/crashdumps crashdumps
RUN ln -s /data/db db
RUN ln -s /data/downloads downloads
RUN ln -s /data/messages messages
RUN ln -s /data/objects objects
RUN ln -s /data/tasks tasks
RUN ln -s /data/translations translations

EXPOSE 7615
EXPOSE 80
EXPOSE 443

VOLUME ["/data"]
ENTRYPOINT ./start
