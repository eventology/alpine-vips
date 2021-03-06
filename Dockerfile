FROM alpine:latest

# Download tarball - downloading from http, verify the checksum
ENV VIPS="vips-8.6.4"

# Install vips
RUN apk add --no-cache glib-dev librsvg-dev python libxml2-dev libexif-dev libpng-dev curl tar gzip \
  nodejs nodejs-npm make g++ gcc libgcc libstdc++ linux-headers \
  giflib-dev tiff-dev libwebp-dev wget gtk-doc expat-dev python && \
  apk add --no-cache --virtual .build-deps librsvg python outils-sha1 && \
  # Download tarball, decompress and delete
  wget "https://github.com/libvips/libvips/releases/download/v8.6.4/vips-8.6.4.tar.gz" && \
  tar -xzf ${VIPS}.tar.gz && \
  # Go into vips directory, build, install, then delete
  cd ${VIPS} && \
  ./configure --with-librsvg && make > /dev/null && make install && \
  cd .. && rm -rf ${VIPS} ${VIPS}.tar.gz && \
  # Remove depenencies
  apk del .build-deps && \
  npm install node-gyp -g