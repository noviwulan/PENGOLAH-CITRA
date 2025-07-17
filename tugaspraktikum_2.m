% Tugas Praktikum 2%

% Memuat package yang dibutuhkan histogram
 pkg load image;


## 1. Menampilkan citra Dan Histogram citra
img = imread('C:/Users/WINDOWS 10/Documents/PENGOLAHAN CITRA/praktikum/gambarcitra/standresize.jpg');
img = im2uint8(img); %gambar dalam format uint8 (0-255)/8bit
figure;
subplot(2,1,1), imshow(img);
title ('Citra');
subplot(2,1,2), imhist(img);
title ('Histogram Citra');

% Pisahkan Channel RGB Dan Tampikan Histogram tiap Warnanya
R =img(:, :, 1); %kanal merah
G =img(:, :, 2); %kanal hijau
B =img(:, :, 3); %kanal biru

figure;
subplot(3,1,1);
imhist(R);
title('Histogram Merah');
xlim([0 255]);

subplot(3,1,2);
imhist(G);
title('Histogram Hijau');
xlim([0 255]);

subplot(3,1,3);
imhist(B);
title('Histogram Biru');
xlim([0 255]);


## 2. Mengkonversi citra RGB ke Grayscale
imgGray = rgb2gray(img); %konversi

figure;
subplot(2,1,1), imshow(img);
title('Citra RGB');
subplot(2,1,2), imshow(imgGray);
title('Citra Grayscale');

## 3. Meningkatkan Kecerahan
imgCerah = imgGray + 50;

figure; %menampilkan hasil citra
subplot(2,1,1), imshow(imgGray);
title('Citra Grayscale');
subplot(2,1,2), imshow(imgCerah);
title('Citra Grayscale + 50');

figure; %menampilkan hasil histogram
subplot(2,1,1),imhist(imgGray);
title('Histogram Sebelum Dicerahkan');
subplot(2,1,2),imhist(imgCerah);
title('Histogram Setelah Dicerahkan');

## 4. Meregangkan Kontras
imgKontras = imgGray * 2,5 ;

figure; %menampilkan hasil citra
subplot(2,1,1), imshow(imgGray);
title('Citra Grayscale');
subplot(2,1,2), imshow(imgKontras);
title('Citra Grayscale * 2,5');

figure; %menampilkan hasil histogram
subplot(2,1,1),imhist(imgGray);
title('Histogram Sebelum Diregangkan');
subplot(2,1,2),imhist(imgKontras);
title('Histogram Setelah Diregangkan');


## 5. Kombinasi kecerahan dan kontras
imgC = imgGray + 50;
imgK = imgC * 2,5;

figure; %kombinasi
subplot(2,1,1), imshow(imgK);
title('Kombinasi Kecerahan & Kontras');
subplot(2,1,2), imhist(imgK);
title('Histogram Kombinasi');


# 6. Membalik citra
imgbalik = 255 - imgGray;

figure; %Membalik Citra Dan Histogram
subplot(2,1,1), imshow(imgbalik);
title('Citra Dibalik');
subplot(2,1,2), imhist(imgbalik);
title('Histogram Dibalik');


# 7. Pemetaan nonlinear
imgLog = uint8(50 * log(1 + double(imgGray)));

figure; %pemetaan nonlinear
subplot(2,1,1), imshow(imgLog);
title('Gambar Hasil Pemetaan Log');
subplot(2,1,2), imhist(imgLog);
title('Histogram Hasil Log Transformasi');


# 8. Pemotongan aras keabuan
threshold = 100; % nilai threshold
imgThreshold = imgGray > threshold;

figure; %Pemotongan aras keabuan
subplot(2,1,1);
imshow(imgThreshold);
title('Hasil Thresholding');

subplot(2,1,2);
imhist(imgThreshold);
title('Histogram setelah Thresholding');

# 9. Ekualisasi Histogram
imgEqual = histeq(imgGray);

figure;
subplot(2,1,1);
imshow(imgEqual);
title('Gambar Setelah Ekualisasi Histogram');

subplot(2,1,2);
imhist(imgEqual);
title('Histogram Setelah Ekualisasi');


