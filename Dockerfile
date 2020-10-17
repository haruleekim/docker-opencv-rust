FROM rust

# Update package manager
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Install dependencies
RUN apt-get install -y --no-install-recommends g++ cmake wget unzip
RUN apt-get install -y --no-install-recommends libavcodec-dev libavformat-dev libavutil-dev libswscale-dev
RUN apt-get install -y --no-install-recommends clang libclang-dev

# Install OpenCV
WORKDIR /
RUN wget -O opencv.zip https://github.com/opencv/opencv/archive/master.zip
RUN unzip opencv.zip && rm opencv.zip
RUN mv opencv-master opencv
RUN mkdir opencv/build
WORKDIR /opencv/build
RUN cmake \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_opencv_apps=ALL \
    -DBUILD_SHARED_LIBS=ON \
    ..
RUN cmake --build . --target install
RUN rm -rf /opencv

# Pass environment variables
ENV LD_LIBRARY_PATH=/usr/local/lib
ENV OpenCV_DIR=/usr/local/lib/cmake/opencv4

