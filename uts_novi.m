% UJIAN TENGAH SEMESTER%
%aktifkan package image
pkg load image;


## SOAL NO 1
#img = imread ('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\taman-uts.jpg');
#gray = rgb2gray(img);
#bw = im2bw(gray);
#subplot(1,3,1), imshow(img), title('CITRA RGB');
#subplot(1,3,2), imshow(gray), title('CITRA GRAYSCALE');
#subplot(1,3,3), imshow(bw), title('CITRA BINER');

## SOAL NO 2
#img2 = im2double(rgb2gray(imread ('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\civic-uts.jpg')));

#quant2 = floor(img2 *2) / 2;
#quant4 = floor(img2 *4) / 4;
#quant8 = floor(img2 *8) / 8;

#figure;
#subplot(2,2,1), imshow(img2), title('Asli Grayscale');
#subplot(2,2,2), imshow(quant2), title('Kuantisasi 2 Tingkat');
#subplot(2,2,3), imshow(quant4), title('Kuantisasi 4 Tingkat');
#subplot(2,2,4), imshow(quant8), title('Kuantisasi 8 Tingkat');

## SOAL NO 3
#img3 = rgb2gray(imread ('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\lorong-uts.jpg'));
#bright = img3 + 80;  % Penyesuaian brightness
#figure;
#subplot(2,2,1), imshow(img3), title('Citra Dark');
#subplot(2,2,2), imshow(bright), title('Citra Bright');

#figure;
#subplot(2,2,1), imhist(img3), title('Citra Sebelum Dicerahkan');
#subplot(2,2,2), imhist(bright), title('Citra Sesudah Dicerahkan');

## SOAL NO 4
#img4 = rgb2gray(imread('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\wajah-uts.jpg'));
#eq = histeq(img4);
#figure;
#subplot(2,2,1), imshow(img4), title('Sebelum');
#subplot(2,2,2), imshow(eq), title('Sesudah');

## SOAL NO 5
#img5 = double(rgb2gray(imread('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\baju-uts.png')));

#median_filtered = medfilt2(img5, [3 3]); % Buat kernel median 3x3
#mean_kernel = fspecial('average', [3 3]);  % Buat kernel rata-rata 3x3
#mean_filtered = imfilter(img5, mean_kernel);

#figure;
#subplot(1,3,1), imshow(img5), title('Citra Sebelum Difilter');
#subplot(1,3,2), imshow(median_filtered), title('Citra Median Filter (3x3)');
#subplot(1,3,3), imshow(mean_filtered), title('Citra Mean Filter (3x3)');

## SOAL NO 6
#img6 = double(imread('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\daunhias-uts.png'));
% High-boost kernel
#hboost = [-1 -1 -1; -1 10 -1; -1 -1 -1];  % Kernel penajaman
% Terapkan filter
#highboost = imfilter(img6, hboost);
% Normalisasi dan ubah ke uint8 untuk ditampilkan
#highboost = uint8(mat2gray(highboost) * 255);
#img6 = uint8(img6);

#figure;
#subplot(2,2,1), imshow(img6), title('Citra Asli');
#subplot(2,2,2), imshow(highboost), title('High Boost');


## SOAL NO 7
#img7 = imread('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\spanduk-uts.png');
#rotated = imrotate(img7, 10, 'bilinear', 'crop');
#resized = imresize(rotated, 3);

#figure;
#subplot (2,3,1), imshow(img7), title('Asli (Miring)');
#subplot (2,3,2), imshow(rotated), title('Rotasi Tegak (Bilinear)');
#subplot (2,3,3), imshow(resized), title('Diperbesar 5x');


## SOAL NO 8
#img8 =  im2double(imread('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\muka-uts.jpg'));

#[rows, cols, ch] = size(img8);
#[X, Y] = meshgrid(1:cols, 1:rows);

% Ubah posisi X dan Y dengan fungsi sinus untuk efek ripple
#rippleX = X + 10 * sin(2 * pi * Y / 30);
#rippleY = Y + 10 * sin(2 * pi * X / 30);

#rippleImg = zeros(rows, cols, ch);

#for k = 1:ch
#  rippleImg(:,:,k) = interp2(X, Y, img8(:,:,k), rippleX, rippleY, 'linear');
#end


#centerX = cols / 2;
#centerY = rows / 2;
#dx = X - centerX;
#dy = Y - centerY;
#r = sqrt(dx.^2 + dy.^2);
#angle = atan2(dy, dx);
#twirl_strength = pi / 256;

#theta = angle + twirl_strength * r;

#Xt = centerX + r .* cos(theta);
#Yt = centerY + r .* sin(theta);

#twirlImg = zeros(rows, cols, ch);

#for k = 1:ch
#  twirlImg(:,:,k) = interp2(X, Y, img8(:,:,k), Xt, Yt, 'linear');
#end

#figure;
#subplot(2,2,1), imshow(img8), title('Asli');
#subplot(2,2,2), imshow(rippleImg), title('Efek Ripple');
#subplot(2,2,3), imshow(twirlImg), title('Efek Twirl');


## SOAL NO 9
#img9 =  im2double(imread('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\motor-uts.jpg'));
#blurred = imgaussfilt(img9, 2);  % Gaussian blur

#figure;
#subplot(2,2,1), imshow(img9), title('Asli');
#subplot(2,2,2), imshow(blurred), title('Gaussian Blur');

## SOAL NO 10
img10 =  im2double(imread('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\gedung-uts.jpg'));
% Definisikan matriks transformasi affine
T = [1 0.1 0; 0.05 1 0; 0 0 1];

% Gunakan maketform dan imtransform
tform = maketform('affine', T);
[out, xdata, ydata] = imtransform(img10, tform, 'XData', [1 size(img10,2)], 'YData', [1 size(img10,1)]);

figure;
subplot(2,2,1), imshow(img10), title('Asli');
subplot(2,2,2), imshow(out), title('Gedung Transformasi Affline');














