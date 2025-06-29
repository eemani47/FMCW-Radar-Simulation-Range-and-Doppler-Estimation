# FMCW Radar Simulation – Range and Doppler Estimation

This project simulates a Frequency-Modulated Continuous Wave (FMCW) radar system in MATLAB to detect multiple targets, estimate their range using beat signals, and extract velocity via Doppler shift analysis. The final output includes a range profile and a range-Doppler map using FFT-based techniques.

## Project Overview

The radar system is modeled with a 77 GHz carrier frequency and designed to detect targets up to 200 meters away with a range resolution of 1 meter. The simulation accounts for the relative motion of targets and simulates both transmitted and received signals, allowing analysis of how range and Doppler information is encoded.

## Simulation Details

- **Radar Type:** FMCW (Frequency-Modulated Continuous Wave)
- **Language:** MATLAB
- **Main File:** `FMCW radar_simulation.m`
- **Output Images:**
  - `1D fft.png` – Range estimation (1D FFT)
  - `2D fft.png` – Range-Doppler map (2D FFT)

## Target Configuration

Three targets are simulated with different positions and velocities:

| Target | Initial Range (m) | Velocity (m/s) |
|--------|--------------------|----------------|
| 1      | 60                 | –40            |
| 2      | 110                | +30            |
| 3      | 160                | 0              |

Each target introduces a unique time delay and Doppler shift in the received signal.

## 1D FFT – Range Estimation

After mixing transmitted and received signals, a 1D FFT is applied along the range (fast-time) dimension to extract beat frequencies corresponding to target distances.

### Output Plot

![1D FFT](./1D%20fft.png)

This plot shows the signal amplitude across different ranges. Peaks correspond to the detected target positions, clearly resolving the three simulated targets.

## 2D FFT – Range-Doppler Map

To extract velocity information, a 2D FFT is performed across both fast-time (range) and slow-time (Doppler) dimensions. The Doppler axis is scaled using the radar wavelength and chirp repetition frequency.

### Output Plot

![2D FFT](./2D%20fft.png)

The image shows target reflections in both range and velocity axes. Negative and positive Doppler shifts indicate motion towards or away from the radar. The static target is seen at zero velocity.

## Observations & Challenges

- **Range Estimation:** Accurate with clear peaks at expected distances.
- **Velocity Estimation:** Reasonable but slightly offset due to FFT bin mismatch.
- **Artifacts:** Spectral leakage from rectangular windowing was noticeable; using a 2D Hamming window improved clarity.
- **Scaling:** Doppler axis calibrated using `lambda` and PRF; minor tuning may improve accuracy.

## How to Run

1. Open `FMCW radar_simulation.m` in MATLAB.
2. Ensure the figures are saved automatically or use `saveas` to generate the two `.png` plots.
3. The script will display:
   - A range plot via 1D FFT.
   - A range-Doppler map via 2D FFT.

## File List

- `FMCW radar_simulation.m` – Main MATLAB script
- `1D fft.png` – Plot showing range estimation via 1D FFT
- `2D fft.png` – Plot showing range-Doppler map via 2D FFT
- `README.md` – Project documentation

## Learning Outcomes

This project helped me understand how radar signal processing works in practice. I explored:

- Chirp signal generation and mixing
- FFT-based feature extraction
- Scaling and interpreting Doppler information
- Trade-offs in resolution, windowing, and FFT accuracy

It was a valuable exercise in combining mathematical modeling with signal visualization to simulate a real-world sensing system.
