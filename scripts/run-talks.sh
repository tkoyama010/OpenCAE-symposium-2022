tmpfile1=$(mktemp --suffix=.wav)
tmpfile2=$(mktemp --suffix=.wav)
rm -f ../wav/*.wav
iscomment=false
conum=0
cat ../index.rst | \
perl -pe "s/-//g" | \
perl -pe "s/=//g" | \
perl -pe "s/conpass/コンパス/g" | \
perl -pe "s/Binder/バインダー/g" | \
perl -pe "s/CalculiX/カリキュリエックス/g" | \
perl -pe "s/Coarse model/コースモデル/g" | \
perl -pe "s/CodeAster/コードアスター/g" | \
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
perl -pe "s/SalomeMeca/サロメメカ/g" | \
perl -pe "s/Sandia/サンディア/g" | \
perl -pe "s/SciPy/サイパイ/g" | \
perl -pe "s/Scilab/サイラボ/g" | \
perl -pe "s/Sphinx/スフィンクス/g" | \
perl -pe "s/The Standard NAFEMS Benchmarks/ザスンタンダードナフェムズベンチマークズ/g" | \
perl -pe "s/Toolkit/ツールキット/g" | \
perl -pe "s/Visualization/ビジュアライゼーション/g" | \
perl -pe "s/issue/イシュー/g" | \
perl -pe "s/meshio/メッシュアイオー/g" | \
perl -pe "s/pyinstaller/パイインストーラー/g" | \
perl -pe "s/pyvista.examples/パイビスタのイグザンプル/g" | \
perl -pe "s/trimesh/トリメッシュ/g" | \
perl -pe "s/この節/このせつ/g" | \
perl -pe "s/パイソンic/パイソニック/g" | \
perl -pe "s/後者の値/後者のあたい/g" | \
while read line
do
    if [ "${line:0:3}" == ".. " ]; then
        conum=`expr $conum + 1`
	finum=`printf "%03d\n" "${conum}"`
        iscomment=true
    elif $iscomment && [ "${line}" == "" ]; then
        iscomment=false
        # aplay ../wav/talk${finum}.wav
    fi
    if "${iscomment}"; then
        echo ${line} | perl -pe "s/^\.\. //g"
        echo ${line} | perl -pe "s/^\.\. //g" | open_jtalk -x /var/lib/mecab/dic/open-jtalk/naist-jdic -m /usr/share/hts-voice/nitech-jp-atr503-m001/nitech_jp_atr503_m001.htsvoice -ow $tmpfile1
        if [ -e ../wav/talk${finum}.wav ]; then
            sox ../wav/talk$finum.wav $tmpfile1 $tmpfile2
            cp $tmpfile2 ../wav/talk${finum}.wav
        else
            cp $tmpfile1 ../wav/talk${finum}.wav
        fi
    fi
done
