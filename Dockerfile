FROM ubuntu:latest

# パッケージリストを更新し、ネットワーク管理ツールをインストール
RUN apt-get update && apt-get install -y \
    # ping: ホストへの接続確認
    iputils-ping \
    # traceroute: パケット経路の確認
    traceroute \
    # mtr: ping と traceroute の統合版
    mtr \
    # netcat: ネットワーク通信テスト
    netcat-openbsd \
    # tcpdump: ネットワークパケットのキャプチャ
    tcpdump \
    # iproute2: ipコマンドツールセット
    iproute2 \
    # net-tools: ifconfig, netstat など
    net-tools \
    # curl: HTTPリクエスト
    curl \
    # wget: ファイルダウンロード
    wget \
    # dnsutils: dig, nslookup
    dnsutils \
    # nmap: ポートスキャンとネットワーク探索
    nmap \
    # iftop: トラフィック監視
    iftop \
    # iptables: パケットフィルタリング
    iptables \
    # arp-scan: ARPによるデバイス検出
    arp-scan \
    # iperf3: 帯域幅測定
    iperf3 \
    # openssh-client: SSHクライアント
    openssh-client \
    # whois: ドメイン情報取得
    whois \
    # rsync: ファイル転送
    rsync \
    # telnet: TCP通信テスト
    telnet \
    # tshark: Wireshark CLI版
    tshark \
    # ebtables: ブリッジ用フィルタリング
    ebtables \
    # bridge-utils: ブリッジ管理ツール
    bridge-utils \
    # ipset: IPセット管理
    ipset \
    # socat: ポートフォワーディングやデータ転送
    socat \
    # htop: リソース監視ツール
    htop \
    # arp: arpコマンドは net-tools に含まれる
    && rm -rf /var/lib/apt/lists/*

# デフォルトのシェルとしてbashを設定
CMD ["bash"]
