
# Power-Efficient Hybrid Booth–Wallace Multiplier

## Project Overview

This project presents the design and implementation of a power-efficient hybrid Booth–Wallace multiplier for signed 8-bit multiplication using Verilog HDL. The architecture combines **Radix-4 Booth encoding, Wallace-style carry-save reduction, and selective least significant bit (LSB) truncation** to reduce switching activity and power consumption.

Conventional multipliers generate and reduce all partial products, increasing hardware activity and power consumption. The proposed architecture intentionally eliminates computations in the two least significant bit positions while retaining the higher-order product bits.

The design was implemented using Verilog HDL, functionally simulated, and synthesized using Cadence Genus with a 90 nm CMOS technology library.

## Objectives

- Design an 8-bit signed multiplier using Radix-4 Booth encoding.
- Reduce the number of partial products generated during multiplication.
- Implement a truncated Wallace-style carry-save reduction network.
- Reduce switching activity by eliminating selected LSB computations.
- Verify the RTL design using simulation test vectors.
- Evaluate power consumption, cell area, and cell count through ASIC synthesis.
- Analyze the trade-off between power efficiency, area, and numerical accuracy.

## Proposed Architecture

The multiplier consists of four primary stages.

### 1. Radix-4 Booth Encoding

Radix-4 Booth encoding processes overlapping groups of three multiplier bits to determine whether the multiplicand should be added, subtracted, doubled, or ignored.

For each Booth group, the recoding selects one of the following operations:

| Booth Code | Operation |
|---|---|
| `000`, `111` | \(0\) |
| `001`, `010` | \(+A\) |
| `011` | \(+2A\) |
| `100` | \(-2A\) |
| `101`, `110` | \(-A\) |

Here, \(A\) is the multiplicand. This encoding reduces the number of partial products compared with conventional radix-2 multiplication.


## Implementation Details

### Design Specifications

| Parameter | Description |
|---|---|
| Architecture | Hybrid Booth–Wallace multiplier |
| Operand width | 8 bits |
| Operand representation | Signed |
| Output width | 16 bits |
| Booth encoding | Radix-4 |
| Reduction structure | Truncated carry-save / Wallace-style |
| Truncation | Two least significant output bits |
| RTL language | Verilog HDL |
| Simulation | Cadence NCSim, as documented in the report |
| Synthesis tool | Cadence Genus |
| Technology library | 90 nm CMOS library |

### Design Flow

1. Define the signed input operands.
2. Apply Radix-4 Booth recoding to the multiplier.
3. Generate and align four signed partial products.
4. Apply carry-save reduction to the relevant bit positions.
5. Omit computation in the two least significant positions.
6. Sign-extend and perform the final addition.
7. Generate the truncated 16-bit product.
8. Simulate the RTL using directed test vectors.
9. Synthesize the design using Cadence Genus.
10. Evaluate power consumption, area, and cell count.

## Verification and Testing

The project report describes testing with positive operands, negative operands, zero, and boundary-value combinations.

Representative test inputs include:

| Operand A | Operand B | Exact Mathematical Product |
|---:|---:|---:|
| 10 | 5 | 50 |
| -7 | 11 | -77 |
| 100 | -50 | -5000 |
| -128 | -128 | 16384 |
| 5 | 0 | 0 |

Since the proposed architecture forces the two LSBs to zero, the RTL output may differ from the exact mathematical product. Expected outputs should therefore be calculated according to the actual truncation and signed-arithmetic implementation.

The supplied report's testbench compares the DUT output with the reference product using simulation messages. A useful improvement is to add self-checking assertions that explicitly account for the intended truncation, followed by exhaustive testing of all \(2^{16}=65{,}536\) possible pairs of signed 8-bit operands.

## Synthesis Results

The following metrics are reported in the mini project report for the proposed design synthesized using the 90 nm CMOS library.

| Parameter | Reported Result |
|---|---:|
| Technology node | 90 nm |
| Cell count | 183 standard cells |
| Cell area | 1246.614 µm² |
| Total power consumption | 0.0522862 mW |
| Total power in watts | \(5.22862\times10^{-5}\) W |

The reported power consumption is approximately 52.29 µW.

### Comparison with the Reference Design

The report compares the proposed design against a reference Booth multiplier reported in 45 nm CMOS.

| Parameter | Proposed Design | Reference Design |
|---|---:|---:|
| Technology node | 90 nm | 45 nm |
| Power consumption | 0.05229 mW | 1.07 mW |
| Cell area | 1246.614 µm² | 539.44 µm² |
| Architecture | Truncated hybrid Booth–Wallace | Optimized Booth multiplier |

## Key Findings

- Radix-4 Booth encoding reduces the number of partial products compared with radix-2 multiplication.
- Truncated carry-save reduction removes computation from the two least significant bit positions.
- The design reports a synthesized power consumption of approximately 0.05229 mW.
- The reported cell area is 1246.614 µm², with 183 standard cells.
- The reference comparison reports approximately 95.11% lower power, alongside an area increase.
- The architecture illustrates how arithmetic truncation can trade numerical precision and area for lower power consumption.

## Limitations

- Truncation introduces numerical error in the least significant portion of the product.
- The reported area is greater than that of the reference design.
- The design is combinational and does not include a pipelined implementation.
- The present architecture is limited to 8-bit signed operands.
- The cross-technology power comparison is not a controlled benchmark.
- The testbench should be extended with explicit pass/fail checks and exhaustive verification.

## Future Scope

- Extend the architecture to 16-bit and 32-bit multipliers.
- Investigate configurable truncation based on application accuracy requirements.
- Explore Dadda-tree reduction and alternative compressor structures.
- Add pipelining to improve throughput and meet higher-frequency targets.
- Evaluate operand isolation and other low-power circuit techniques.
- Compare architectures using the same technology library, constraints, and synthesis flow.
- Perform exhaustive functional verification and document error metrics for all input combinations.

## Repository Structure

```text
power-efficient-booth-wallace-multiplier/
├── README.md
├── rtl/
│   └── booth_wallace8_trunc2.v
├── testbench/
│   └── tb_booth_wallace8_trunc2.v
├── simulation/
│   └── waveforms/
├── synthesis/
│   ├── area/
│   ├── power/
│   └── timing/
├── reports/
│   └── project-report.pdf
└── docs/
    └── architecture.md
```

This structure is a suggested organization. Add the actual source files, reports, and waveforms before publishing.
