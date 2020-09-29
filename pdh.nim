import winim/lean

type PDH_COUNTER_INFO* = object
    dwLength*: DWord
    dwType*: DWord
    CVersion*: DWord
    CStatus*: DWord
    lScale*: LONG
    lDefaultScale*: LONG
    dwUserData*: DWORD_PTR
    dwQueryUserData*: DWORD_PTR
    szFullPath*: LPSTR

# CPU使用情報が入る構造体
type PPDH_FMT_COUNTERVALUE* = object
    CStatus*: DWORD
    longValue*: LONG
    doubleValue*: DOUBLE
    largeValue*: LONGLONG
    AnsiStringValue*: LPCSTR
    WideStringValue*: LPCWSTR


# dllから必要関数のロード
proc PdhOpenQuery*(szDataSource: LPVOID, dwUserData: PDH_COUNTER_INFO, phQuery: ptr int): WINBOOL {.stdcall, dynlib: "Pdh", importc: "PdhOpenQueryA".}
proc PdhAddCounter*(hQuery: int, szFullCounterPath: LPCSTR, dwUserData: DWORD_PTR, phCounter: ptr int): WINBOOL {.stdcall, dynlib: "Pdh", importc: "PdhAddCounterA".}
proc PdhCollectQueryData*(hQuery: int): LONG {.stdcall, dynlib: "Pdh", importc: "PdhCollectQueryData".}
proc PdhGetFormattedCounterValue*(hCounter: int, dwFormat: DWORD, lpdwType: LPDWORD, pValue: ptr PPDH_FMT_COUNTERVALUE) {.stdcall, dynlib: "Pdh", importc: "PdhGetFormattedCounterValue".}
