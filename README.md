# audio_common_temp

```bash
mkdir ~/ros2_ws/src -p
cd ~/ros2_ws/src
git clone https://github.com/lolddohaja/audio_common_temp
cd ~/ros2_ws/src/audio_common_temp
vcs import ../ < ./audio.repos
cd ..
rosdep install --from-paths . -y -r -i
cd ~/ros2_ws
colcon build
```

아직 PR이 승인 되지 않아서 이렇게 빌드해서 사용해야 한다.

참고 이슈

https://github.com/ros-drivers/audio_common/issues/227

https://github.com/ros-drivers/audio_common/pull/248

사용법

```bash
ros2 run sound_play soundplay_node.py
```