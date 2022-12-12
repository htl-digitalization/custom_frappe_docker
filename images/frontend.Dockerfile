ARG FRAPPE_VERSION
ARG ERPNEXT_VERSION

FROM frappe/bench:latest as assets

ARG FRAPPE_VERSION
RUN bench init --version=develop --frappe-branch develop --skip-redis-config-generation --verbose --skip-assets /home/frappe/frappe-bench
RUN python -m pip install --quiet --upgrade -e /home/frappe/frappe-bench/apps/frappe

WORKDIR /home/frappe/frappe-bench

# Uncomment following if ERPNext is required
ARG ERPNEXT_VERSION
RUN bench get-app --branch=version-14 --skip-assets --resolve-deps erpnext

COPY --chown=frappe:frappe repos apps

RUN bench setup requirements

RUN bench build --production --verbose --hard-link

FROM hieutrluu/erpnext-nginx-develop:${FRAPPE_VERSION}

USER root

RUN rm -fr /usr/share/nginx/html/assets

COPY --from=assets /home/frappe/frappe-bench/sites/assets /usr/share/nginx/html/assets
COPY images/nginx-template.conf /etc/nginx/templates/default.conf.template
USER 1000
