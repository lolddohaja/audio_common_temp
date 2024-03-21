# audio_common_temp

default ROS2 iron check

```bash
docker build -t zetabank/outside:iron-audio-v0.0.1 -f Dockerfile .
```


아직 PR이 승인 되지 않아서 이렇게 빌드해서 사용해야 한다.

참고 이슈

https://github.com/ros-drivers/audio_common/issues/227

https://github.com/ros-drivers/audio_common/pull/248

사운드카드 번호 고정시키는 법

lsusb 명령어를 사용해서 사운드 제품을 찾는다.
```bash
lsusb
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 003 Device 002: ID 001f:0b21 Generic iStore Audio
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 1546:01a9 U-Blox AG u-blox GNSS receiver
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

해당 제품의 idVendor와 idProduct를 찾아 `/etc/udev/rules.d` 폴더에 규칙 파일을 생성한다.

```bash
echo 'ACTION=="add", SUBSYSTEM=="sound", ATTRS{idVendor}=="001f", ATTRS{idProduct}=="0b21", ATTR{index}="2"' | sudo tee /etc/udev/rules.d/99-usb-audio.rules
```

한 번에 찾고 만드는 방법이다. 카드의 번호는 2번으로 설정했다.
```bash
lsusb | grep Audio | head -n1 | awk '{print $6}' | sudo awk -F ':' '{system("echo ACTION=\\\"add\\\", SUBSYSTEM=\\\"sound\\\", ATTRS{idVendor}=\\\"" $1 "\\\", ATTRS{idProduct}=\\\"" $2 "\\\", ATTR{index}=\\\"2\\\" > /etc/udev/rules.d/99-usb-audio.rules")}'
```

사용법

```bash
# ros2 run sound_play soundplay_node.py
docker run --rm -it --device=/dev/snd:/dev/snd -e ALSA_CARD=2 zetabank/outside:iron-audio-v0.0.1 ros2 run sound_play soundplay_node.py
```

```bash
# ros2 run sound_play play.py /절대경로/음악이름.mp3
docker run --rm -it zetabank/outside:iron-audio-v0.0.1 ros2 run sound_play play.py /root/sounds/voice/start.mp3
```

필요한 음악이 있을 때는  soundplay_node를 실행할 때 새로 등록 해줘야한다.

예시
1번 터미널
```bash
docker run --rm -it --device=/dev/snd:/dev/snd -v /home/zeta/docker/test.mp3:/root/test.mp3 -e ALSA_CARD=1 zetabank/outside:iron-audio-v0.0.1 ros2 run sound_play soundplay_node.py
```
2번 터미널
```bash
docker run --rm -it zetabank/outside:iron-audio-v0.0.1 ros2 run sound_play play.py /root/test.mp3
```