# audio_common_temp

```bash
mkdir ~/ros2_ws/src/ -p
git clone https://github.com/lolddohaja/audio_common_temp
cd ~/ros2_ws/src/audio_common_temp
vcs import < ~/audio.repos
rosdep install --from-paths . -y -r -i
cd ~/ros2_ws
colcon build
```