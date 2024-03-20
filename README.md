# audio_common_temp

default ROS2 iron check

```bash
docker build -t zetabank/outside:iron-audio-v0.0.1 -f Dockerfile .
```

아직 PR이 승인 되지 않아서 이렇게 빌드해서 사용해야 한다.

참고 이슈

https://github.com/ros-drivers/audio_common/issues/227

https://github.com/ros-drivers/audio_common/pull/248

사용법

```bash
ros2 run sound_play soundplay_node.py

docker run --rm -it --device=/dev/snd:/dev/snd -e ALSA_CARD=1 zetabank/outside:iron-audio-v0.0.1 ros2 run sound_play soundplay_node.py
```

```bash
ros2 run sound_play play.py /절대경로/음악이름.mp3

docker run --rm -it zetabank/outside:iron-audio-v0.0.1 ros2 run sound_play play.py /root/sounds/voice/start.mp3
```
