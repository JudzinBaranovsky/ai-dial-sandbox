FROM codiumai/pr-agent:0.30

RUN apt-get update && \
    apt-get install -y tcpdump

COPY qodo-instrumented.sh ./qodo-instrumentation.sh

ENTRYPOINT ["./qodo-instrumentation.sh"]
