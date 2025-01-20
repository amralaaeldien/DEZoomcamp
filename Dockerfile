FROM python:3.9

RUN apt-get update && apt-get install -y wget && apt-get -y install libpq-dev gcc && apt-get clean \
&& rm -rf /var/lib/apt/lists/*
RUN pip install psycopg2-binary pandas Jupyter sqlalchemy

COPY . .

ENTRYPOINT [ "bash" ]

