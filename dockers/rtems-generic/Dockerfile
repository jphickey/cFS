
FROM debian:bullseye AS dev-base
RUN apt-get update && apt-get install -y sudo git make build-essential flex bison texinfo python-dev g++ unzip libz-dev libssl-dev libcurl4-gnutls-dev libexpat1-dev gettext cmake mtools udev bsdmainutils dosfstools
RUN groupadd -g 1000 dev
RUN useradd -c 'Docker Developer' -d /work -m -s /bin/bash -u 1000 -g 1000 -G sudo dev
RUN mkdir -p /usr/src /opt
RUN chown -R dev:dev /usr/src /opt
USER dev
WORKDIR /usr/src

FROM dev-base AS rtems-xtool
ARG RTEMS_VERSION=5
ARG RTEMS_ARCH=i386
ENV RTEMS_PREFIX=/opt/rtems-${RTEMS_VERSION}
USER dev
RUN git clone --depth 1 -b ${RTEMS_VERSION} -- git://git.rtems.org/rtems-source-builder.git
WORKDIR /usr/src/rtems-source-builder/rtems
RUN ../source-builder/sb-set-builder --prefix=${RTEMS_PREFIX} ${RTEMS_VERSION}/rtems-${RTEMS_ARCH}
ENV PATH=${RTEMS_PREFIX}/bin:${PATH}
RUN echo "RTEMS_VERSION=${RTEMS_VERSION}" | tee -a ${RTEMS_PREFIX}/VERSION_INFO
RUN echo "RTEMS_ARCH=${RTEMS_ARCH}" | tee -a ${RTEMS_PREFIX}/VERSION_INFO
RUN echo "RTEMS_PREFIX=${RTEMS_PREFIX}" | tee -a ${RTEMS_PREFIX}/VERSION_INFO
RUN date +"RTEMS_XTOOL_VERSION=$(git rev-parse --short HEAD)-%Y%M%d" | tee -a ${RTEMS_PREFIX}/VERSION_INFO
WORKDIR /usr/src

FROM rtems-xtool AS rtems-source
ARG RTEMS_VERSION=5
ENV RTEMS_PREFIX=/opt/rtems-${RTEMS_VERSION}
USER dev
WORKDIR /usr/src
RUN git clone --depth 1 -b ${RTEMS_VERSION} -- git://git.rtems.org/rtems.git
WORKDIR /usr/src/rtems
RUN ./bootstrap
RUN date +"RTEMS_SOURCE_VERSION=$(git rev-parse --short HEAD)-%Y%M%d" | tee -a ${RTEMS_PREFIX}/VERSION_INFO


FROM rtems-source AS rtems-bsp
ARG RTEMS_VERSION=5
ARG RTEMS_ARCH=i386
ARG RTEMS_BSP=pc686
ENV RTEMS_PREFIX=/opt/rtems-${RTEMS_VERSION}
ENV RTEMS_TARGET=${RTEMS_ARCH}-rtems${RTEMS_VERSION}
USER dev
RUN mkdir -p /work/b-${RTEMS_BSP}
WORKDIR /work/b-${RTEMS_BSP}
RUN /usr/src/rtems/configure \
    --target=${RTEMS_TARGET} \
    --prefix=${RTEMS_PREFIX} \
    --enable-rtemsbsp=${RTEMS_BSP} \
    --enable-networking \
    --enable-cxx \
    --disable-posix \
    --disable-deprecated \
    BSP_ENABLE_VGA=0 \
    CLOCK_DRIVER_USE_TSC=1 \
    USE_COM1_AS_CONSOLE=1 \
    BSP_PRESS_KEY_FOR_RESET=0 \
    BSP_RESET_BOARD_AT_EXIT=1
RUN make
RUN echo "RTEMS_TARGET=${RTEMS_TARGET}" | tee -a ${RTEMS_PREFIX}/VERSION_INFO
RUN echo "RTEMS_BSP=${RTEMS_BSP}" | tee -a ${RTEMS_PREFIX}/VERSION_INFO
USER root
RUN make install
RUN chown -R root:root /opt

FROM scratch AS dev-sdk
COPY --from=rtems-bsp /opt /opt

FROM dev-base AS dev-builder
ARG RTEMS_VERSION=5
ENV RTEMS_PREFIX=/opt/rtems-${RTEMS_VERSION}
COPY --from=rtems-bsp /opt /opt
ENV PATH=${RTEMS_PREFIX}/bin:${PATH}
USER dev
WORKDIR /work
RUN mkdir -p src
RUN ln -s ${RTEMS_PREFIX} rtems-${RTEMS_VERSION}
ENTRYPOINT [ "/usr/bin/tail", "-f", "/dev/null" ]
