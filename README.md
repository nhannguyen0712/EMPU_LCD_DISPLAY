# Dự án: Màn hình hiển thị xe đạp điện thông minh dựa trên FPGA Gowin

[cite_start]Dự án này trình bày một hệ thống màn hình hiển thị thông minh cho xe đạp điện, được thiết kế trên một thiết bị **FPGA Gowin GW1NSR-LV4C** với lõi cứng **ARM Cortex-M3 (Gowin-EMPU)**[cite: 70, 71]. [cite_start]Màn hình LCD 5.4" hiển thị thông tin về xe đạp điện, giao tiếp với FPGA qua giao diện **SPI**[cite: 11, 12, 13].

[cite_start]Hệ thống cũng giao tiếp với bộ điều khiển động cơ qua **UART** và đọc đầu vào từ các nút bấm của người dùng[cite: 15, 19].

---

## Sơ đồ khối hệ thống

Hệ thống được tổ chức như sau:

* [cite_start]**Bộ xử lý trung tâm**: Gowin FPGA 4K GW1NSR-LV4C với lõi cứng ARM Cortex-M3[cite: 7].
* [cite_start]**Hiển thị**: Màn hình **LCD PANEL 5.4"** được điều khiển bởi **TFT DRIVER ILI9341**, giao tiếp với FPGA qua giao diện **SPI**[cite: 11, 12, 13].
* **Giao tiếp**:
    * [cite_start]**UART**: Kết nối với **MOTOR DRIVER** thông qua **BUFFER IC** và một **UART PORT**, sử dụng "5S PROTOCOL"[cite: 19, 20, 21, 22, 23].
    * [cite_start]**GPIO**: Kết nối với các **User Button** (2 chân I/O) và các chỉ báo **LED Indicator** (2 chân I/O)[cite: 14, 15, 16, 17].
* **Bộ nhớ**:
    * [cite_start]**EEPROM**: Giao tiếp qua I2C[cite: 5, 6].
    * [cite_start]**SPI FLASH P25Q64**: Giao tiếp qua các chân I/O[cite: 8, 9].
* [cite_start]**Nguồn**: Một bộ chuyển đổi **BUCK DC-DC** giảm điện áp từ **48V** xuống **5V, 3.3V, và 1.2V** để cấp nguồn cho hệ thống[cite: 26, 27, 28, 29].

---

## Cấu hình chân vật lý (File `EMPU.cst`)

[cite_start]File `EMPU.cst` định nghĩa các ràng buộc vật lý, ánh xạ các tín hiệu trong thiết kế của bạn đến các chân cụ thể trên chip FPGA[cite: 47, 48]. [cite_start]Các chân GPIO trong lõi cứng EMPU được đánh số từ 0 đến 15[cite: 49].

Dưới đây là một số chân quan trọng được định nghĩa trong file này:

* [cite_start]`GPIO_BL`: Chân 44[cite: 44, 52].
* [cite_start]`GPIO_DC`: Chân 40[cite: 40, 51].
* [cite_start]`GPIO_RST`: Chân 39[cite: 39, 50].
* [cite_start]`GPIO_SCK`: Chân 41[cite: 41, 51].
* [cite_start]`GPIO_MOSI`: Chân 43[cite: 43, 52].
* [cite_start]`crystalClk`: Chân 45[cite: 49, 50].
* [cite_start]`resetButton`: Chân 15[cite: 49, 50].

---

## Mô-đun cấp cao nhất (File `empu_top.v`)

[cite_start]File `empu_top.v` là mô-đun Verilog cấp cao nhất, nơi các chân vật lý được khai báo và kết nối với bus **GPIO 16-bit** (`empu_gpio`) của EMPU[cite: 38, 39, 45].

Các chân được khai báo và gán như sau:

* [cite_start]`GPIO_BL` -> `empu_gpio[9]`[cite: 40].
* [cite_start]`GPIO_RST` -> `empu_gpio[4]`[cite: 41].
* [cite_start]`GPIO_DC` -> `empu_gpio[5]`[cite: 42].
* [cite_start]`GPIO_SCK` -> `empu_gpio[6]`[cite: 43].
* [cite_start]`GPIO_MOSI` -> `empu_gpio[8]`[cite: 44].

[cite_start]Mô-đun này cũng khởi tạo lõi cứng **`Gowin_EMPU_Top`** và kết nối nó với các chân đầu vào/đầu ra của hệ thống[cite: 45].

---

## Hướng dẫn sử dụng

[cite_start]Để phát triển dự án này, bạn cần sử dụng phần mềm **Gowin MCU Design (GMD)**[cite: 75].

1.  **Thiết kế MCU**: Firmware cho **ARM Cortex-M3** sẽ được viết trong GMD. [cite_start]Firmware này điều khiển giao diện SPI để giao tiếp với ILI9341, đọc dữ liệu từ UART và xử lý đầu vào từ các nút bấm[cite: 75, 77, 294, 301].
2.  [cite_start]**Thiết kế FPGA**: Trong GMD, bạn sẽ cấu hình IP lõi cứng **Gowin-EMPU** và kích hoạt các thiết bị ngoại vi cần thiết như **GPIO** và **UART**[cite: 259, 301, 310].
3.  [cite_start]**Tải mã**: Sau khi biên dịch, bạn có thể nạp tệp `.bin` vào FPGA bằng Gowin Programmer[cite: 205, 335].
