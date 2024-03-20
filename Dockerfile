FROM ros:iron-ros-base

ARG NETRC

SHELL ["bash", "-c"]

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN mkdir -p ~/ros2_ws/src \
    && cd ~/ros2_ws/src \ 
    && git clone -b iron_docker https://github.com/lolddohaja/audio_common_temp.git \ 
    && cd ~/ros2_ws/src/audio_common_temp \ 
    && vcs import ../ < ./audio.repos \ 
    && cd ~/ros2_ws \ 
    && rosdep install --from-paths src -y -r -i \  
    && colcon build

RUN sed -i '$isource "/root/ros2_ws/install/setup.bash"' /ros_entrypoint.sh

# RUN rosdep update --rosdistro $ROS_DISTRO

# RUN apt update && rosdep install --from-paths src --ignore-src --rosdistro $ROS_DISTRO -y

# RUN . /opt/ros/$ROS_DISTRO/setup.sh \
#   && colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release

# RUN sed -i '$isource "/opt/turtlebot3/install/setup.bash"' /ros_entrypoint.sh

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]