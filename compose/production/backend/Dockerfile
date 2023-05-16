FROM python:3.7

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

WORKDIR /usr/src/app

RUN apt-get update \
  # dependencies for building Python packages
  && apt-get install -y build-essential libpq-dev netcat \
  # pygraphviz dependencies 
  && apt-get install -y graphviz libgraphviz-dev pkg-config \
  # translations dependencies
  && apt-get install -y gettext \
  # cleaning up unused files
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

# install requirements
COPY ./backend/requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r ./requirements.txt
# copy project
COPY ./backend .

COPY ./compose/production/backend/entrypoint.sh /entrypoint
RUN sed -i 's/\r$//g' /entrypoint
RUN chmod +x /entrypoint

COPY ./compose/production/backend/start.sh /start
RUN sed -i 's/\r$//g' /start
RUN chmod +x /start

ENTRYPOINT ["/entrypoint"]
