FROM alpine:3.7
MAINTAINER Chance Hudson

# Download tarball - downloading from http, verify the checksum
ENV VIPS="vips-8.5.9"

# Install vips
RUN apk add --no-cache glib-dev libxml2-dev libexif-dev libpng-dev curl tar gzip \
  giflib-dev tiff-dev libwebp-dev wget gtk-doc expat-dev && \
  apk add --no-cache --virtual .build-deps g++ make python outils-sha1 && \
# Download tarball, decompress and delete
  wget "https://github.com/jcupitt/libvips/releases/download/v8.5.9/vips-8.5.9.tar.gz" && \
  tar -xzf ${VIPS}.tar.gz && \
# Go into vips directory, build, install, then delete
  cd ${VIPS} && \
  ./configure && make > /dev/null && make install && \
  cd .. && rm -rf ${VIPS} ${VIPS}.tar.gz && \
# Remove depenencies
  apk del .build-deps
