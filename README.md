# **Network Tools Docker Image**

この Docker イメージは、ネットワーク管理および診断に必要なツールを網羅した環境を提供します。  
疎通確認、パケットキャプチャ、ポートスキャン、帯域幅テストなどの目的に利用できます。

---

## **概要**

このイメージに含まれるツールは以下の通りです。

| ツール           | 説明                                           |
| ---------------- | ---------------------------------------------- |
| **ping**         | ホストへの接続確認                             |
| **traceroute**   | パケットの経路確認                             |
| **mtr**          | `ping` と `traceroute` の統合版                |
| **netcat (nc)**  | ポート確認や通信テスト                         |
| **tcpdump**      | ネットワークパケットのキャプチャ               |
| **nmap**         | ポートスキャンとネットワーク探索               |
| **iftop**        | リアルタイムのネットワークトラフィック監視     |
| **iperf3**       | ネットワーク帯域幅の測定                       |
| **dig**          | DNS クエリ確認                                 |
| **arp-scan**     | ネットワーク内のデバイス検出                   |
| **curl/wget**    | HTTP リクエスト送信、ファイル取得              |
| **telnet**       | TCP 接続テスト                                 |
| **whois**        | ドメイン・IP の情報取得                        |
| **tshark**       | Wireshark の CLI 版（高度なパケット解析）      |
| **ebtables**     | ブリッジネットワーク用のパケットフィルタリング |
| **bridge-utils** | Linux ブリッジ管理ツール                       |
| **ipset**        | IP アドレスセットの管理                        |
| **socat**        | データ転送やポートフォワーディング             |
| **rsync**        | ファイル転送                                   |
| **htop**         | システムリソース監視ツール                     |

---

## **Docker イメージの構築と利用方法**

### **1. イメージのビルド**

```bash
docker build -t network-tools:latest .
```

### **2. コンテナの起動**

```bash
docker run -it --name network-tools-container network-tools:latest
```

---

## **各ツールの使用例と実行結果**

### **1. ping: ホストへの接続確認**

**コマンド:**

```bash
ping google.com
```

**実行結果サンプル:**

```
PING google.com (142.250.196.110) 56(84) bytes of data.
64 bytes from 142.250.196.110: icmp_seq=1 ttl=115 time=20.3 ms
64 bytes from 142.250.196.110: icmp_seq=2 ttl=115 time=20.5 ms
64 bytes from 142.250.196.110: icmp_seq=3 ttl=115 time=20.7 ms
```

**結果の見方:**

- `icmp_seq`: ICMP メッセージのシーケンス番号。
- `ttl`: ルーターを通過する最大ホップ数（Time To Live）。
- `time`: 応答時間（ミリ秒）。

---

### **2. traceroute: パケット経路の確認**

**コマンド:**

```bash
traceroute google.com
```

**実行結果サンプル:**

```
traceroute to google.com (142.250.196.110), 30 hops max, 60 byte packets
 1  192.168.1.1 (192.168.1.1)  1.123 ms  1.108 ms  1.083 ms
 2  10.0.0.1 (10.0.0.1)  3.345 ms  3.290 ms  3.267 ms
 3  142.250.196.110 (142.250.196.110)  20.301 ms  20.284 ms  20.312 ms
```

**結果の見方:**

- 各行は 1 つのホップ（ルーター）を示します。
- 最後の行に目的地の IP アドレスが表示されると成功です。

---

### **3. mtr: 経路確認 + リアルタイム統計**

**コマンド:**

```bash
mtr google.com
```

**実行結果サンプル:**

```
Start: 2024-06-08T12:34:56+0000
HOST: container                  Loss%   Snt   Last   Avg  Best  Wrst StDev
  1.|-- 192.168.1.1              0.0%    10    0.5    0.6   0.5   1.0   0.1
  2.|-- 10.0.0.1                 0.0%    10    3.3    3.4   3.3   3.7   0.1
  3.|-- google.com (142.250.196.110) 0.0%  10   20.2   20.5  20.2  21.0   0.3
```

**結果の見方:**

- `Loss%`: パケットの損失率。
- `Avg`: 平均応答時間。
- `Best` と `Wrst`: 最速と最遅の応答時間。

---

### **4. tcpdump: パケットキャプチャ**

**コマンド:**

```bash
tcpdump -i eth0
```

**実行結果サンプル:**

```
12:34:56.789123 IP 192.168.1.10 > 142.250.196.110: ICMP echo request, id 1, seq 1, length 64
12:34:56.789456 IP 142.250.196.110 > 192.168.1.10: ICMP echo reply, id 1, seq 1, length 64
```

**結果の見方:**

- `IP`: 使用されるプロトコル。
- `> 142.250.196.110`: 宛先 IP。
- `ICMP echo request/reply`: パケットの種類。

---

### **5. nmap: ポートスキャン**

**コマンド:**

```bash
nmap 192.168.1.1
```

**実行結果サンプル:**

```
Starting Nmap 7.80 ( https://nmap.org ) at 2024-06-08 12:34 UTC
Nmap scan report for 192.168.1.1
Host is up (0.001s latency).
PORT   STATE SERVICE
22/tcp open  ssh
80/tcp open  http
```

**結果の見方:**

- `PORT`: スキャン対象のポート番号。
- `STATE`: `open` はサービスが起動中。
- `SERVICE`: サービス名。

---

### **6. iftop: トラフィック監視**

**コマンド:**

```bash
iftop -i eth0
```

**実行結果サンプル:**

```
             192.168.1.10   =>   142.250.196.110     1.01Mb   1.01Mb   1.01Mb
             192.168.1.10   <=   142.250.196.110     500Kb    500Kb    500Kb
```

**結果の見方:**

- `=>` および `<=`: 送信/受信トラフィック。
- `1.01Mb`: 帯域使用量。

---

### **7. iperf3: 帯域幅測定**

**サーバー側:**

```bash
iperf3 -s
```

**クライアント側:**

```bash
iperf3 -c <サーバーIP>
```

**実行結果サンプル:**

```
[  5]   0.00-1.00   sec  100 MBytes   840 Mbits/sec
[  5]   1.00-2.00   sec  101 MBytes   847 Mbits/sec
```

**結果の見方:**

- `Mbits/sec`: 帯域幅。
