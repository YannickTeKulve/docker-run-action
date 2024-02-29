FROM docker:25.0.3-dind

RUN apk add bash

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
