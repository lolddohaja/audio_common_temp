FROM ros:iron-ros-base

ARG NETRC

SHELL ["bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN apt-get update && \
    apt-get install -y \
    ros-iron-test-interface-files \
    ros-iron-performance-test-fixture \
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
    python3-jsonschema

RUN mkdir -p ~/ros2_ws/src \
    && cd ~/ros2_ws/src \ 
    && git clone -b iron_docker https://github.com/lolddohaja/audio_common_temp.git \ 
    && cd ~/ros2_ws/src/audio_common_temp \ 
    && vcs import ../ < ./audio.repos \ 
    && cd ~/ros2_ws \ 
    && rosdep update \
    && rosdep install --from-paths src -y -r -i \
    && . /opt/ros/$ROS_DISTRO/setup.sh \
    && colcon build

RUN sed -i '$isource "/root/ros2_ws/install/setup.bash"' /ros_entrypoint.sh

# RUN rosdep update --rosdistro $ROS_DISTRO

# RUN apt update && rosdep install --from-paths src --ignore-src --rosdistro $ROS_DISTRO -y

# RUN . /opt/ros/$ROS_DISTRO/setup.sh \
#   && colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

# RUN sed -i '$isource "/opt/turtlebot3/install/setup.bash"' /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]