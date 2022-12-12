ARG FRAPPE_VERSION
ARG ERPNEXT_VERSION

FROM frappe/bench:latest as assets

ARG FRAPPE_VERSION
RUN bench init --version=develop --verbose --skip-assets /home/frappe/frappe-bench

WORKDIR /home/frappe/frappe-bench

# Uncomment following if ERPNext is required
ARG ERPNEXT_VERSION
RUN bench get-app --branch=version-14 --skip-assets --resolve-deps erpnext

COPY --chown=frappe:frappe repos apps

RUN bench setup requirements

RUN bench build --production --verbose --hard-link

FROM hieutrluu/frappe-nginx-develop:${FRAPPE_VERSION}

USER root

RUN rm -fr /usr/share/nginx/html/assets

COPY --from=assets /home/frappe/frappe-bench/sites/assets /usr/share/nginx/html/assets
COPY images/nginx-template.conf /etc/nginx/templates/default.conf.template
USER 1000
