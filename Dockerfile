


FROM python:3.9
WORKDIR /app/backend
COPY requirements.txt /app/backend

# Add Chrome and WebDriver installation
RUN apt-get update \
    && apt-get install -y wget unzip gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config google-chrome-stable \
    && wget https://chromedriver.storage.googleapis.com/$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && mv chromedriver /usr/bin/chromedriver \
    && chmod +x /usr/bin/chromedriver \
    && rm -rf /var/lib/apt/lists/*

RUN pip install mysqlclient
RUN pip install selenium webdriver-manager pytest
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/backend
EXPOSE 8000
