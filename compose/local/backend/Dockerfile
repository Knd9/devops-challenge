FROM python:3.7

# set environment variables
# this keeps Python from buffering stdin/stdout.
ENV PYTHONUNBUFFERED 1
# this prevents Python from writing out pyc files.
ENV PYTHONDONTWRITEBYTECODE 1

# set working directory
WORKDIR /usr/src/app

RUN apt-get update \
  # dependencies for building Python packages
  && apt-get install -y gcc libpq-dev python3-dev musl-dev git netcat \
  # psycopg2
  && apt-get install -y postgresql \
  # pygraphviz dependencies 
  && apt-get install -y graphviz libgraphviz-dev pkg-config \
  # translations dependencies
  && apt-get install -y gettext \
  # cleaning up unused files
  && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

# requirements are installed here to ensure they will be cached.
COPY ./backend/requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r ./requirements.txt
# copy project
COPY ./backend .

COPY ./compose/local/backend/entrypoint.sh /entrypoint
RUN sed -i 's/\r$//g' /entrypoint
RUN chmod +x /entrypoint

COPY ./compose/local/backend/start.sh /start
RUN sed -i 's/\r$//g' /start
RUN chmod +x /start

ENTRYPOINT ["/entrypoint"]
