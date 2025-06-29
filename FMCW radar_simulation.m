clear;

% Radar Parameters
c = 3e8;
fc = 77e9;
lambda = c / fc;

range_max = 200;
range_res = 1;
v_max = 100;

B = c / (2 * range_res);
Tchirp = 5.5 * 2 * range_max / c;
slope = B / Tchirp;

Nr = 1024;  % samples per chirp
Nd = 256;   % number of chirps
PRF = 1 / Tchirp;

t = linspace(0, Nd*Tchirp, Nr*Nd);

% Targets: [range, velocity]
targets = [60, -40;
           110, 30;
           160, 0];

Tx = zeros(1, length(t));
Rx = zeros(1, length(t));

for i = 1:size(targets, 1)
    R = targets(i, 1);
    v = targets(i, 2);
    r_t = R + v * t;
    tau = 2 * r_t / c;
    
    tx = cos(2*pi*(fc*t + slope*t.^2/2));
    rx = cos(2*pi*(fc*(t - tau) + slope*(t - tau).^2/2));
    
    Tx = Tx + tx;
    Rx = Rx + rx;
end

Mix = Tx .* Rx;

% Reshape to 2D matrix
Mix2D = reshape(Mix, [Nr, Nd]);
window = hamming(Nr) * hamming(Nd)';
Mix2D = Mix2D .* window;

% 1D FFT on Range dimension
rangeFFT = fft(Mix2D, Nr);
rangeFFT = abs(rangeFFT) / Nr;
rangeFFT = rangeFFT(1:Nr/2, 1);
rangeAxis = (0:Nr/2-1) * c / (2 * B);

figure('Name','Range FFT');
plot(rangeAxis, rangeFFT);
xlabel('Range (m)'); ylabel('Amplitude');
title('Range Estimation'); grid on;

% 2D FFT on Range and Doppler
sig2D = fft2(Mix2D, Nr, Nd);
sig2D = sig2D(1:Nr/2, :);
sig2D = fftshift(sig2D, 2);  % center Doppler axis
sig2D = abs(sig2D);
sig2D = 10*log10(sig2D / max(sig2D(:)) + 1e-6);

% Doppler Axis Correction
fd = (-Nd/2:Nd/2-1) * PRF / Nd;
vAxis = fd * lambda / 2;

% Plot Range-Doppler Map
figure('Name','Range-Doppler Map');
imagesc(vAxis, rangeAxis, sig2D);
xlabel('Velocity (m/s)');
ylabel('Range (m)');
title('Range-Doppler Map');
colorbar;
set(gca, 'YDir', 'normal');