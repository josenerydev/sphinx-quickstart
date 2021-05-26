FROM sphinxdoc/sphinx-latexpdf as build

WORKDIR /app

COPY . .

RUN pip3 install -r requirements.txt

RUN make html

RUN make latexpdf

FROM nginx:stable-alpine

COPY --from=build app/_build/html /usr/share/nginx/html

COPY --from=build app/_build/latex/sphinxquickstart.pdf /usr/share/nginx/html

EXPOSE 80

CMD ["nginx","-g", "daemon off;"]
