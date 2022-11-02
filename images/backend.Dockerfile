# syntax=docker/dockerfile:1.3

ARG ERPNEXT_VERSION
FROM frappe/erpnext-worker:${ERPNEXT_VERSION}

COPY repos ../apps

USER root
RUN apt-get update
RUN apt-get install python3-cffi python3-brotli libpango-1.0-0 libharfbuzz0b libpangoft2-1.0-0 libgtk-3-dev gcc -y

RUN install-app chat && \
    install-app posawesome && \
    install-app wiki && \
    install-app lms && \
    install-app tpp_erpnext

USER frappe
