# syntax=docker/dockerfile:1.3

ARG ERPNEXT_VERSION
FROM frappe/erpnext-worker:${ERPNEXT_VERSION}

COPY repos ../apps

USER root

RUN install-app chat && \
    install-app posawesome && \
    install-app wiki && \
    install-app lms && \
    install-app press && \
    # install-app castlecraft && \
    # install-app microsoft_integration && \
    install-app tpp_erpnext && \ 
    install-app tpp_custom

USER frappe
