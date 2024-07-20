FROM python:3.12-slim

RUN mkdir agri.io-app

COPY build/web agri.io-app

USER 10001

EXPOSE 9000

ENTRYPOINT ["python3","-m", "http.server","-d","agri.io-app","9000"]