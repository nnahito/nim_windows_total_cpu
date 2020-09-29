import winim/lean
import os
import pdh

var dwUserData: PDH_COUNTER_INFO
var hQuery: int
discard PdhOpenQuery(nil, dwUserData, &hQuery)

var hCounter: int
var lpcstrStr: LPCSTR
lpcstrStr = "\\Processor(_Total)\\% Processor Time"     # ←トータルのCPU使用率を取得するためのおまじない（これ指定で取得できるらしい）
discard PdhAddCounter(hQuery, lpcstrStr, 0, &hCounter)

# CPU使用率の収集
discard PdhCollectQueryData(hQuery)

for i in 0..100:
    sleep(1000)
    # CPU使用率の収集。前回の収集からここまででの、CPU使用率が取得される
    discard PdhCollectQueryData(hQuery)

    # 人間様にわかるようにCPU使用率をフォーマット
    var fmtValue: PPDH_FMT_COUNTERVALUE
    PdhGetFormattedCounterValue(hCounter, 512, nil, &fmtValue)

    # CPU使用率の吐き出し
    echo "CPU使用率は " & $fmtValue.doubleValue & "% だよ"
