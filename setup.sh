# ardupilotと TeamChiuUdoKuuを同じディレクトリに置く
# $ ls
# TeamChiuUdoKuu  ardupilot
cd ardupilot/ArduSub
# pwd
# ardupilot/ArduSub
# Ardusub以下にTeamChuudokuのscriptをシンボリックリンクを作成しておいて
# コピーするのをやめる
 ln -s ../../TeamChiuUdoKuu scripts

 #
 sim_vehicle.py -L RATBeach --map --console

