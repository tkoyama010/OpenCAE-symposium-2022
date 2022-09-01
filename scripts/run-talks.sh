tmpfile1=$(mktemp --suffix=.wav)
tmpfile2=$(mktemp --suffix=.wav)
rm -f talk.wav
cat ../index.rst | \
perl -pe "s/-//g" | \
perl -pe "s/=//g" | \
perl -pe "s/Binder/バインダー/g" | \
perl -pe "s/CalculiX/カリキュリエックス/g" | \
perl -pe "s/Coarse model/コースモデル/g" | \
perl -pe "s/Code-Aster/コードアスター/g" | \
perl -pe "s/Cook membrane/クックメンブレン/g" | \
perl -pe "s/Discussions/ディスカッション/g" | \
perl -pe "s/Elliptic Membrane/エリプティクメンブレン/g" | \
perl -pe "s/FEABeR/フィーバー/g" | \
perl -pe "s/Fine model/ファインモデル/g" | \
perl -pe "s/Finite Element Analysis Benchmark Report/フィニットエレメントアナリシスベンチマークレポート/g" | \
perl -pe "s/FrontISTR/フロントアイスター/g" | \
perl -pe "s/GetFEM/ゲットエフイーエム/g" | \
perl -pe "s/Jupyter Lab/ジュパイターラボ/g" | \
perl -pe "s/Jupyter/ジュパイター/g" | \
perl -pe "s/Linear elastic solid/リニアーエラスティクソリッド/g" | \
perl -pe "s/Matlab/マトラボ/g" | \
perl -pe "s/Matplotlib/マットプロットリブ/g" | \
perl -pe "s/Newmark/ニューマーク/g" | \
perl -pe "s/NumPy/ナムパイ/g" | \
perl -pe "s/Octave/オクターブ/g" | \
perl -pe "s/ParaView/パラビュー/g" | \
perl -pe "s/Pull Request/プルリクエスト/g" | \
perl -pe "s/PyVista/パイビスタ/g" | \
perl -pe "s/Python/パイソン/g" | \
perl -pe "s/Read The Docs/リードザドックス/g" | \
perl -pe "s/Salome-Meca/サロメメカ/g" | \
perl -pe "s/Sandia/サンディア/g" | \
perl -pe "s/SciPy/サイパイ/g" | \
perl -pe "s/Scilab/サイラボ/g" | \
perl -pe "s/Sphinx/スフィンクス/g" | \
perl -pe "s/The Standard NAFEMS Benchmarks/ザスンタンダードナフェムズベンチマークズ/g" | \
perl -pe "s/Toolkit/ツールキット/g" | \
perl -pe "s/Visualization/ビジュアライゼーション/g" | \
perl -pe "s/^     //g" | \
perl -pe "s/^#//g" | \
perl -pe "s/^\.\. //g" | \
perl -pe "s/^\n//g" | \
perl -pe "s/issue/イシュー/g" | \
perl -pe "s/meshio/メッシュアイオー/g" | \
perl -pe "s/pyinstaller/パイインストーラー/g" | \
perl -pe "s/pyvista.example/パイビスタのイグザンプル/g" | \
perl -pe "s/trimesh/トリメッシュ/g" | \
perl -pe "s/この節/このせつ/g" | \
perl -pe "s/パイソンic/パイソニック/g" | \
perl -pe "s/後者の値/後者のあたい/g" | \
while read line
do
    echo $line
    echo $line | open_jtalk -x /var/lib/mecab/dic/open-jtalk/naist-jdic -m /usr/share/hts-voice/nitech-jp-atr503-m001/nitech_jp_atr503_m001.htsvoice -ow $tmpfile1
    if [ -e ../talk.wav ]; then
        sox ../talk.wav $tmpfile1 $tmpfile2
        cp $tmpfile2 ../talk.wav
    else
        cp $tmpfile1 ../talk.wav
    fi
done
time aplay ../talk.wav
