FROM docker.io/library/debian:buster
RUN apt update \
  && apt --no-install-recommends --yes install \
    python3-pip fortune fortunes-min \
  && apt clean
# optionally world languages fortune
# fortunes-br fortunes-cs fortunes-es \
# fortunes-fr fortunes-it fortunes-pl fortunes-ru fortunes-zh   
WORKDIR /app
COPY . /app

RUN pip3 --no-cache-dir install -r requirements.txt

EXPOSE 8080
CMD ["/app/app.py"]
