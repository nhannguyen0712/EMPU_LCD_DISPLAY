module empu_top (
    input resetButton,
    input crystalClk,

    // Khai báo các chân riêng lẻ theo chỉ định
    inout GPIO_BL,        // Chân 44
    inout GPIO_DC,        // Chân 40
    inout GPIO_RST,       // Chân 39
    inout GPIO_SCK,       // Chân 41

    inout GPIO_MOSI       // Chân 43
);
    // Khai báo một wire 16-bit cho cổng gpio của EMPU
    wire [15:0] empu_gpio;

    // Gán các chân vật lý vào các chân GPIO tương ứng của EMPU
    // GPIO[9] -> Chân vật lý 44
    assign empu_gpio[9] = GPIO_BL;

    // GPIO[4] -> Chân vật lý 39
    assign empu_gpio[4] = GPIO_RST;

    // GPIO[5] -> Chân vật lý 40
    assign empu_gpio[5] = GPIO_DC;

    // GPIO[6] -> Chân vật lý 41
    assign empu_gpio[6] = GPIO_SCK;

    // GPIO[7] -> Chân vật lý 42


    // GPIO[8] -> Chân vật lý 43
    assign empu_gpio[8] = GPIO_MOSI;


    // Gán các chân còn lại của bus EMPU vào trạng thái high-impedance
  

    // Khai báo module EMPU
    Gowin_EMPU_Top cortexM3 (
        .sys_clk(crystalClk),
        .gpio(empu_gpio),
        .mosi(),
        .miso(),
        .sclk(),
        .nss(),
        .reset_n(resetButton)
    );

endmodule