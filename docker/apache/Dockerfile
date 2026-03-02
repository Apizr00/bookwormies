FROM httpd:2.4-alpine

# Enable required modules
RUN sed -i \
  -e 's/^#\(LoadModule .*mod_rewrite.so\)/\1/' \
  -e 's/^#\(LoadModule .*mod_proxy.so\)/\1/' \
  -e 's/^#\(LoadModule .*mod_proxy_fcgi.so\)/\1/' \
  /usr/local/apache2/conf/httpd.conf

# Include our custom configuration
RUN echo "Include conf/extra/laravel.conf" >> /usr/local/apache2/conf/httpd.conf

# Change document root
RUN sed -i 's#/usr/local/apache2/htdocs#/var/www/html/public#g' /usr/local/apache2/conf/httpd.conf
