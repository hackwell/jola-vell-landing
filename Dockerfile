FROM nginx:alpine

# Copy the landing page, legal pages and assets
COPY *.html /usr/share/nginx/html/
COPY assets/ /usr/share/nginx/html/assets/

# Custom nginx config for SPA-like behavior
RUN echo 'server { \
    listen 80; \
    server_name _; \
    root /usr/share/nginx/html; \
    index index.html; \
    location / { \
        try_files $uri $uri/ /index.html; \
        add_header Cache-Control "public, max-age=3600"; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
