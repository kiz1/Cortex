FROM thehiveproject/cortex:3.1.8-withdeps
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    python3-pip \
    python3-dev \
    ssdeep \
    libfuzzy-dev \
    libfuzzy2 \
    libimage-exiftool-perl \
    libmagic1 \
    build-essential \
    git \
    libssl-dev \
    gnupg \
    curl \
    unzip \
    wget \
    iputils-ping \
    software-properties-common \
    locales
RUN pip3 install -U pip setuptools
# Skip cache to update cortex analyzers
ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
# Fixing an error "exit_status 73"
RUN chown root:root /var/log
# Installation tshark
#RUN add-apt-repository -y ppa:wireshark-dev/stable
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y tshark
# Installation google-chrome browser and chromedriver for Selenium
RUN apt-get update && \
    apt-get install -y --no-install-recommends gnupg wget curl unzip && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends google-chrome-stable && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
    CHROME_VERSION=$(google-chrome --product-version) && \
    wget -q --continue -P /chromedriver "https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROME_VERSION/linux64/chromedriver-linux64.zip" && \
    unzip /chromedriver/chromedriver* -d /usr/local/bin/ && \
    rm -rf /chromedriver
RUN mkdir -p /home/cortex
RUN chown cortex:cortex -R /home/cortex/
# Install RU locale
RUN sed -i '/ru_RU.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG=ru_RU.UTF-8
ENV LANGUAGE=ru_RU:ru
ENV LC_ALL=ru_RU.UTF-8
# Clone public analayzers
RUN git clone https://github.com/TheHive-Project/Cortex-Analyzers.git \
/opt/Cortex-Analyzers
# Clone private analayzers
RUN git clone ***/cortex-analyzers.git \
/tmp/cortex-analyzers
WORKDIR /tmp/cortex-analyzers
RUN cp -r analyzers responders thehive-templates  /opt/Cortex-Analyzers/
# Installation python requirements
RUN for I in $(find /opt/Cortex-Analyzers -name 'requirements.txt'); do pip3 install -r $I || true; done
RUN for I in $(find /opt/Cortex-Analyzers -name '*.py'); do chmod +x $I || true; done
WORKDIR /opt/cortex
