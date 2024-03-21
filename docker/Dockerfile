FROM amr-gnss-iron
ENV DEBIAN_FRONTEND=noninteractive

ARG NETRC

SHELL ["bash", "-c"]


RUN apt-get update && apt-get install -y \
    git \
    python3-vcstool \
    ros-dev-tools \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN apt-get update && \
    apt-get install -y \
    ros-$ROS_DISTRO-test-interface-files \
    ros-$ROS_DISTRO-performance-test-fixture \
    festival \
    festvox-kallpc16k \
    gstreamer1.0-tools \
    libgstreamer1.0-0 \
    gir1.2-gstreamer-1.0 \
    gstreamer1.0-alsa \
    gstreamer1.0-plugins-base \
    libgstreamer-plugins-base1.0-0 \
    gir1.2-gst-plugins-base-1.0 \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-plugins-good \
    libgstreamer-plugins-good1.0-0 \
    python3-gi \
    libboost-all-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    python3-jsonschema \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/ws/src \
    && cd /root/ws/src \ 
    && git clone -b iron_docker https://github.com/lolddohaja/audio_common_temp.git \ 
    && cd /root/ws/src/audio_common_temp \ 
    && vcs import ../ < ./audio.repos \ 
    && cd /root/ws \ 
    && rosdep update \
    && rosdep install --from-paths src -y -r -i \
    && source /opt/ros/$ROS_DISTRO/setup.sh \
    && colcon build

RUN mv /root/ws/src/audio_common_temp/sounds /root

RUN echo "source /root/ws/install/setup.bash" >> ~/.bashrc

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]