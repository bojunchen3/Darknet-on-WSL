import subprocess
import threading
import time
import re
stop_monitor = False
max_power = 0.0
max_ram = 0.0

def measure_gpu_usage():
    """監控 GPU 使用情況，更新最大功耗與記憶體使用量"""
    global max_power, max_ram, stop_monitor
    while not stop_monitor:
        try:
            # 使用 nvidia-smi 查詢 power.draw 和 memory.used
            output = subprocess.check_output([
                "nvidia-smi.exe",
                "--query-gpu=power.draw,memory.used",
                "--format=csv,noheader,nounits"
            ])
            # 解析輸出，如 "30.10, 500" -> power_str="30.10", mem_str="500"
            line = output.decode('utf-8').strip().split('\n')[0]
            power_str, mem_str = line.split(',')

            if power_str.strip() != '[N/A]':
                power_val = float(power_str.strip())
                max_power = max(max_power, power_val)

            if mem_str.strip() != '[N/A]':
                mem_val = float(mem_str.strip())
                max_ram = max(max_ram, mem_val)
        except Exception as e:
            print(f"查詢失敗: {e}")
        time.sleep(0.1)  # 每 0.1 秒讀一次

# 啟動 GPU 使用監控執行緒
monitor_thread = threading.Thread(target=measure_gpu_usage)
monitor_thread.start()

# 執行 Darknet 指令，並捕捉其輸出
command = ["./darknet", "detector", "test", "cfg/coco.data", "cfg/yolov3.cfg", "yolov3.weights", "-dont_show", "-ext_output"]
try:
    process = subprocess.Popen(
        command,
        stdin=open("list.txt", "r"),  # 將 list.txt 作為標準輸入
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True
    )

    all_output = ""  # 用來存儲完整輸出
    for line in iter(process.stdout.readline, ""):
        print(line, end="")  # 即時輸出到控制台
        all_output += line

    process.wait()  # 等待指令完成
finally:
    stop_monitor = True
    monitor_thread.join()

# 印出 GPU 使用情況的總結
print(f"\n整個過程中 GPU 最大功耗約為: {max_power:.2f} W")
print(f"整個過程中 GPU 最大記憶體使用量約為: {max_ram:.2f} MB")

# 分析 YOLO 輸出，計算平均推論時間
lines = all_output.split('\n')
times = []
for line in lines:
    # 使用正則表達式抓取 "Predicted in xx.xx ms."
    m = re.search(r"Predicted in ([\d.]+) milli-seconds\.", line)
    if m:
        times.append(float(m.group(1)))

if times:
    avg_time = sum(times) / len(times)
    print(f"\n共推論 {len(times)} 張影像")
    print(f"平均推論時間: {avg_time:.2f} ms")
    print(f"等效 FPS: {1000/avg_time:.2f} (不含後處理/IO)")
else:
    print("\n未找到任何 'Predicted in xx.xx ms.' 相關輸出，請檢查 Darknet 輸出格式。")