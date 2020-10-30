FROM rust

# Update package manager
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Install dependencies
RUN apt-get install -y --no-install-recommends clang libclang-dev g++ cmake pkg-config wget unzip
RUN apt-get install -y --no-install-recommends \
		build-essential \
		libatlas-base-dev \
		libavcodec-dev \
		libavformat-dev \
		libavresample-dev \
		libceres-dev \
		libdc1394-22-dev \
		libeigen3-dev \
		libfreetype6-dev \
		libgdal-dev \
		libgflags-dev \
		libgoogle-glog-dev \
		libgphoto2-dev \
		libgstreamer-plugins-base1.0-dev \
		libharfbuzz-dev \
		libhdf5-dev \
		libjpeg-dev \
		liblapacke-dev \
		libleptonica-dev \
		libopenexr-dev \
		libpng-dev \
		libswscale-dev \
		libtbb-dev \
		libtesseract-dev \
		libtiff-dev \
		libwebp-dev

# Install OpenCV
WORKDIR /
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/master.zip
RUN unzip opencv.zip && rm opencv.zip
RUN mv opencv-master opencv
RUN mkdir opencv/build
WORKDIR /opencv/build
RUN cmake \
    -D BUILD_TESTS=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_opencv_apps=ALL \
    -D BUILD_SHARED_LIBS=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    ..
RUN make -j4
RUN make install

# Pass build time environment variables
ENV OpenCV_DIR=/usr/local/cmake/opencv4
ENV LD_LIBRARY_PATH=/usr/local/lib

