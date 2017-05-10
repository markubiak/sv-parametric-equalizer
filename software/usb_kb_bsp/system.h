/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_qsys_0' in SOPC Builder design 'nios_system'
 * SOPC Builder design path: ../../nios_system.sopcinfo
 *
 * Generated: Sun Apr 30 13:37:27 CDT 2017
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00001820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1c
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x08000020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x1c
#define ALT_CPU_NAME "nios2_qsys_0"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x08000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00001820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x1c
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x08000020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x1c
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x08000000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_NIOS2_GEN2
#define __ALTPLL


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x2100
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x2100
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x2100
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "nios_system"


/*
 * biquad_index configuration
 *
 */

#define ALT_MODULE_CLASS_biquad_index altera_avalon_pio
#define BIQUAD_INDEX_BASE 0x2070
#define BIQUAD_INDEX_BIT_CLEARING_EDGE_REGISTER 0
#define BIQUAD_INDEX_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BIQUAD_INDEX_CAPTURE 0
#define BIQUAD_INDEX_DATA_WIDTH 3
#define BIQUAD_INDEX_DO_TEST_BENCH_WIRING 0
#define BIQUAD_INDEX_DRIVEN_SIM_VALUE 0
#define BIQUAD_INDEX_EDGE_TYPE "NONE"
#define BIQUAD_INDEX_FREQ 50000000
#define BIQUAD_INDEX_HAS_IN 0
#define BIQUAD_INDEX_HAS_OUT 1
#define BIQUAD_INDEX_HAS_TRI 0
#define BIQUAD_INDEX_IRQ -1
#define BIQUAD_INDEX_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BIQUAD_INDEX_IRQ_TYPE "NONE"
#define BIQUAD_INDEX_NAME "/dev/biquad_index"
#define BIQUAD_INDEX_RESET_VALUE 0
#define BIQUAD_INDEX_SPAN 16
#define BIQUAD_INDEX_TYPE "altera_avalon_pio"


/*
 * coefficient configuration
 *
 */

#define ALT_MODULE_CLASS_coefficient altera_avalon_pio
#define COEFFICIENT_BASE 0x2080
#define COEFFICIENT_BIT_CLEARING_EDGE_REGISTER 0
#define COEFFICIENT_BIT_MODIFYING_OUTPUT_REGISTER 0
#define COEFFICIENT_CAPTURE 0
#define COEFFICIENT_DATA_WIDTH 18
#define COEFFICIENT_DO_TEST_BENCH_WIRING 0
#define COEFFICIENT_DRIVEN_SIM_VALUE 0
#define COEFFICIENT_EDGE_TYPE "NONE"
#define COEFFICIENT_FREQ 50000000
#define COEFFICIENT_HAS_IN 0
#define COEFFICIENT_HAS_OUT 1
#define COEFFICIENT_HAS_TRI 0
#define COEFFICIENT_IRQ -1
#define COEFFICIENT_IRQ_INTERRUPT_CONTROLLER_ID -1
#define COEFFICIENT_IRQ_TYPE "NONE"
#define COEFFICIENT_NAME "/dev/coefficient"
#define COEFFICIENT_RESET_VALUE 0
#define COEFFICIENT_SPAN 16
#define COEFFICIENT_TYPE "altera_avalon_pio"


/*
 * f_string configuration
 *
 */

#define ALT_MODULE_CLASS_f_string altera_avalon_pio
#define F_STRING_BASE 0x2040
#define F_STRING_BIT_CLEARING_EDGE_REGISTER 0
#define F_STRING_BIT_MODIFYING_OUTPUT_REGISTER 0
#define F_STRING_CAPTURE 0
#define F_STRING_DATA_WIDTH 30
#define F_STRING_DO_TEST_BENCH_WIRING 0
#define F_STRING_DRIVEN_SIM_VALUE 0
#define F_STRING_EDGE_TYPE "NONE"
#define F_STRING_FREQ 50000000
#define F_STRING_HAS_IN 0
#define F_STRING_HAS_OUT 1
#define F_STRING_HAS_TRI 0
#define F_STRING_IRQ -1
#define F_STRING_IRQ_INTERRUPT_CONTROLLER_ID -1
#define F_STRING_IRQ_TYPE "NONE"
#define F_STRING_NAME "/dev/f_string"
#define F_STRING_RESET_VALUE 0
#define F_STRING_SPAN 16
#define F_STRING_TYPE "altera_avalon_pio"


/*
 * g_string configuration
 *
 */

#define ALT_MODULE_CLASS_g_string altera_avalon_pio
#define G_STRING_BASE 0x2030
#define G_STRING_BIT_CLEARING_EDGE_REGISTER 0
#define G_STRING_BIT_MODIFYING_OUTPUT_REGISTER 0
#define G_STRING_CAPTURE 0
#define G_STRING_DATA_WIDTH 30
#define G_STRING_DO_TEST_BENCH_WIRING 0
#define G_STRING_DRIVEN_SIM_VALUE 0
#define G_STRING_EDGE_TYPE "NONE"
#define G_STRING_FREQ 50000000
#define G_STRING_HAS_IN 0
#define G_STRING_HAS_OUT 1
#define G_STRING_HAS_TRI 0
#define G_STRING_IRQ -1
#define G_STRING_IRQ_INTERRUPT_CONTROLLER_ID -1
#define G_STRING_IRQ_TYPE "NONE"
#define G_STRING_NAME "/dev/g_string"
#define G_STRING_RESET_VALUE 0
#define G_STRING_SPAN 16
#define G_STRING_TYPE "altera_avalon_pio"


/*
 * hal configuration
 *
 */

#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x2100
#define JTAG_UART_0_IRQ 5
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * onchip_memory2_0 configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory2_0 altera_avalon_onchip_memory2
#define ONCHIP_MEMORY2_0_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_0_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_0_BASE 0x0
#define ONCHIP_MEMORY2_0_CONTENTS_INFO ""
#define ONCHIP_MEMORY2_0_DUAL_PORT 0
#define ONCHIP_MEMORY2_0_GUI_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_0_INIT_CONTENTS_FILE "nios_system_onchip_memory2_0"
#define ONCHIP_MEMORY2_0_INIT_MEM_CONTENT 1
#define ONCHIP_MEMORY2_0_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY2_0_IRQ -1
#define ONCHIP_MEMORY2_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY2_0_NAME "/dev/onchip_memory2_0"
#define ONCHIP_MEMORY2_0_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_0_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_0_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY2_0_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY2_0_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_0_SIZE_VALUE 4096
#define ONCHIP_MEMORY2_0_SPAN 4096
#define ONCHIP_MEMORY2_0_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY2_0_WRITABLE 1


/*
 * otg_hpi_address configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_address altera_avalon_pio
#define OTG_HPI_ADDRESS_BASE 0x20c0
#define OTG_HPI_ADDRESS_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_ADDRESS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_ADDRESS_CAPTURE 0
#define OTG_HPI_ADDRESS_DATA_WIDTH 2
#define OTG_HPI_ADDRESS_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_ADDRESS_DRIVEN_SIM_VALUE 0
#define OTG_HPI_ADDRESS_EDGE_TYPE "NONE"
#define OTG_HPI_ADDRESS_FREQ 50000000
#define OTG_HPI_ADDRESS_HAS_IN 0
#define OTG_HPI_ADDRESS_HAS_OUT 1
#define OTG_HPI_ADDRESS_HAS_TRI 0
#define OTG_HPI_ADDRESS_IRQ -1
#define OTG_HPI_ADDRESS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_ADDRESS_IRQ_TYPE "NONE"
#define OTG_HPI_ADDRESS_NAME "/dev/otg_hpi_address"
#define OTG_HPI_ADDRESS_RESET_VALUE 0
#define OTG_HPI_ADDRESS_SPAN 16
#define OTG_HPI_ADDRESS_TYPE "altera_avalon_pio"


/*
 * otg_hpi_cs configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_cs altera_avalon_pio
#define OTG_HPI_CS_BASE 0x20d0
#define OTG_HPI_CS_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_CS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_CS_CAPTURE 0
#define OTG_HPI_CS_DATA_WIDTH 1
#define OTG_HPI_CS_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_CS_DRIVEN_SIM_VALUE 0
#define OTG_HPI_CS_EDGE_TYPE "NONE"
#define OTG_HPI_CS_FREQ 50000000
#define OTG_HPI_CS_HAS_IN 0
#define OTG_HPI_CS_HAS_OUT 1
#define OTG_HPI_CS_HAS_TRI 0
#define OTG_HPI_CS_IRQ -1
#define OTG_HPI_CS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_CS_IRQ_TYPE "NONE"
#define OTG_HPI_CS_NAME "/dev/otg_hpi_cs"
#define OTG_HPI_CS_RESET_VALUE 0
#define OTG_HPI_CS_SPAN 16
#define OTG_HPI_CS_TYPE "altera_avalon_pio"


/*
 * otg_hpi_data configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_data altera_avalon_pio
#define OTG_HPI_DATA_BASE 0x20b0
#define OTG_HPI_DATA_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_DATA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_DATA_CAPTURE 0
#define OTG_HPI_DATA_DATA_WIDTH 16
#define OTG_HPI_DATA_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_DATA_DRIVEN_SIM_VALUE 0
#define OTG_HPI_DATA_EDGE_TYPE "NONE"
#define OTG_HPI_DATA_FREQ 50000000
#define OTG_HPI_DATA_HAS_IN 1
#define OTG_HPI_DATA_HAS_OUT 1
#define OTG_HPI_DATA_HAS_TRI 0
#define OTG_HPI_DATA_IRQ -1
#define OTG_HPI_DATA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_DATA_IRQ_TYPE "NONE"
#define OTG_HPI_DATA_NAME "/dev/otg_hpi_data"
#define OTG_HPI_DATA_RESET_VALUE 0
#define OTG_HPI_DATA_SPAN 16
#define OTG_HPI_DATA_TYPE "altera_avalon_pio"


/*
 * otg_hpi_r configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_r altera_avalon_pio
#define OTG_HPI_R_BASE 0x20a0
#define OTG_HPI_R_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_R_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_R_CAPTURE 0
#define OTG_HPI_R_DATA_WIDTH 1
#define OTG_HPI_R_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_R_DRIVEN_SIM_VALUE 0
#define OTG_HPI_R_EDGE_TYPE "NONE"
#define OTG_HPI_R_FREQ 50000000
#define OTG_HPI_R_HAS_IN 0
#define OTG_HPI_R_HAS_OUT 1
#define OTG_HPI_R_HAS_TRI 0
#define OTG_HPI_R_IRQ -1
#define OTG_HPI_R_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_R_IRQ_TYPE "NONE"
#define OTG_HPI_R_NAME "/dev/otg_hpi_r"
#define OTG_HPI_R_RESET_VALUE 0
#define OTG_HPI_R_SPAN 16
#define OTG_HPI_R_TYPE "altera_avalon_pio"


/*
 * otg_hpi_w configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_w altera_avalon_pio
#define OTG_HPI_W_BASE 0x2090
#define OTG_HPI_W_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_W_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_W_CAPTURE 0
#define OTG_HPI_W_DATA_WIDTH 1
#define OTG_HPI_W_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_W_DRIVEN_SIM_VALUE 0
#define OTG_HPI_W_EDGE_TYPE "NONE"
#define OTG_HPI_W_FREQ 50000000
#define OTG_HPI_W_HAS_IN 0
#define OTG_HPI_W_HAS_OUT 1
#define OTG_HPI_W_HAS_TRI 0
#define OTG_HPI_W_IRQ -1
#define OTG_HPI_W_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_W_IRQ_TYPE "NONE"
#define OTG_HPI_W_NAME "/dev/otg_hpi_w"
#define OTG_HPI_W_RESET_VALUE 0
#define OTG_HPI_W_SPAN 16
#define OTG_HPI_W_TYPE "altera_avalon_pio"


/*
 * q_String configuration
 *
 */

#define ALT_MODULE_CLASS_q_String altera_avalon_pio
#define Q_STRING_BASE 0x2010
#define Q_STRING_BIT_CLEARING_EDGE_REGISTER 0
#define Q_STRING_BIT_MODIFYING_OUTPUT_REGISTER 0
#define Q_STRING_CAPTURE 0
#define Q_STRING_DATA_WIDTH 30
#define Q_STRING_DO_TEST_BENCH_WIRING 0
#define Q_STRING_DRIVEN_SIM_VALUE 0
#define Q_STRING_EDGE_TYPE "NONE"
#define Q_STRING_FREQ 50000000
#define Q_STRING_HAS_IN 0
#define Q_STRING_HAS_OUT 1
#define Q_STRING_HAS_TRI 0
#define Q_STRING_IRQ -1
#define Q_STRING_IRQ_INTERRUPT_CONTROLLER_ID -1
#define Q_STRING_IRQ_TYPE "NONE"
#define Q_STRING_NAME "/dev/q_String"
#define Q_STRING_RESET_VALUE 0
#define Q_STRING_SPAN 16
#define Q_STRING_TYPE "altera_avalon_pio"


/*
 * sdram configuration
 *
 */

#define ALT_MODULE_CLASS_sdram altera_avalon_new_sdram_controller
#define SDRAM_BASE 0x8000000
#define SDRAM_CAS_LATENCY 3
#define SDRAM_CONTENTS_INFO
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_IRQ -1
#define SDRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_IS_INITIALIZED 1
#define SDRAM_NAME "/dev/sdram"
#define SDRAM_POWERUP_DELAY 200.0
#define SDRAM_REFRESH_PERIOD 7.8125
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SDRAM_ADDR_WIDTH 0x19
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_SDRAM_COL_WIDTH 10
#define SDRAM_SDRAM_DATA_WIDTH 16
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SHARED_DATA 0
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SPAN 67108864
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_T_AC 5.5
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 20.0
#define SDRAM_T_RFC 70.0
#define SDRAM_T_RP 20.0
#define SDRAM_T_WR 14.0


/*
 * sdram_pll configuration
 *
 */

#define ALT_MODULE_CLASS_sdram_pll altpll
#define SDRAM_PLL_BASE 0x20e0
#define SDRAM_PLL_IRQ -1
#define SDRAM_PLL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_PLL_NAME "/dev/sdram_pll"
#define SDRAM_PLL_SPAN 16
#define SDRAM_PLL_TYPE "altpll"


/*
 * sysid_qsys_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sysid_qsys_0 altera_avalon_sysid_qsys
#define SYSID_QSYS_0_BASE 0x20f8
#define SYSID_QSYS_0_ID 0
#define SYSID_QSYS_0_IRQ -1
#define SYSID_QSYS_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_QSYS_0_NAME "/dev/sysid_qsys_0"
#define SYSID_QSYS_0_SPAN 8
#define SYSID_QSYS_0_TIMESTAMP 1493576055
#define SYSID_QSYS_0_TYPE "altera_avalon_sysid_qsys"


/*
 * to_hw_sig configuration
 *
 */

#define ALT_MODULE_CLASS_to_hw_sig altera_avalon_pio
#define TO_HW_SIG_BASE 0x2060
#define TO_HW_SIG_BIT_CLEARING_EDGE_REGISTER 0
#define TO_HW_SIG_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TO_HW_SIG_CAPTURE 0
#define TO_HW_SIG_DATA_WIDTH 4
#define TO_HW_SIG_DO_TEST_BENCH_WIRING 0
#define TO_HW_SIG_DRIVEN_SIM_VALUE 0
#define TO_HW_SIG_EDGE_TYPE "NONE"
#define TO_HW_SIG_FREQ 50000000
#define TO_HW_SIG_HAS_IN 0
#define TO_HW_SIG_HAS_OUT 1
#define TO_HW_SIG_HAS_TRI 0
#define TO_HW_SIG_IRQ -1
#define TO_HW_SIG_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TO_HW_SIG_IRQ_TYPE "NONE"
#define TO_HW_SIG_NAME "/dev/to_hw_sig"
#define TO_HW_SIG_RESET_VALUE 0
#define TO_HW_SIG_SPAN 16
#define TO_HW_SIG_TYPE "altera_avalon_pio"


/*
 * to_sw_sig configuration
 *
 */

#define ALT_MODULE_CLASS_to_sw_sig altera_avalon_pio
#define TO_SW_SIG_BASE 0x2050
#define TO_SW_SIG_BIT_CLEARING_EDGE_REGISTER 0
#define TO_SW_SIG_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TO_SW_SIG_CAPTURE 0
#define TO_SW_SIG_DATA_WIDTH 2
#define TO_SW_SIG_DO_TEST_BENCH_WIRING 0
#define TO_SW_SIG_DRIVEN_SIM_VALUE 0
#define TO_SW_SIG_EDGE_TYPE "NONE"
#define TO_SW_SIG_FREQ 50000000
#define TO_SW_SIG_HAS_IN 1
#define TO_SW_SIG_HAS_OUT 0
#define TO_SW_SIG_HAS_TRI 0
#define TO_SW_SIG_IRQ -1
#define TO_SW_SIG_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TO_SW_SIG_IRQ_TYPE "NONE"
#define TO_SW_SIG_NAME "/dev/to_sw_sig"
#define TO_SW_SIG_RESET_VALUE 0
#define TO_SW_SIG_SPAN 16
#define TO_SW_SIG_TYPE "altera_avalon_pio"


/*
 * type_index configuration
 *
 */

#define ALT_MODULE_CLASS_type_index altera_avalon_pio
#define TYPE_INDEX_BASE 0x2020
#define TYPE_INDEX_BIT_CLEARING_EDGE_REGISTER 0
#define TYPE_INDEX_BIT_MODIFYING_OUTPUT_REGISTER 0
#define TYPE_INDEX_CAPTURE 0
#define TYPE_INDEX_DATA_WIDTH 3
#define TYPE_INDEX_DO_TEST_BENCH_WIRING 0
#define TYPE_INDEX_DRIVEN_SIM_VALUE 0
#define TYPE_INDEX_EDGE_TYPE "NONE"
#define TYPE_INDEX_FREQ 50000000
#define TYPE_INDEX_HAS_IN 0
#define TYPE_INDEX_HAS_OUT 1
#define TYPE_INDEX_HAS_TRI 0
#define TYPE_INDEX_IRQ -1
#define TYPE_INDEX_IRQ_INTERRUPT_CONTROLLER_ID -1
#define TYPE_INDEX_IRQ_TYPE "NONE"
#define TYPE_INDEX_NAME "/dev/type_index"
#define TYPE_INDEX_RESET_VALUE 0
#define TYPE_INDEX_SPAN 16
#define TYPE_INDEX_TYPE "altera_avalon_pio"

#endif /* __SYSTEM_H_ */
