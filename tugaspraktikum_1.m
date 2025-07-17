%TUGAS PRAKTIKUM 1%

%MEMBACA CITRA%
 img = imread('bangunan.png');
%MENAMPILKAN CITRA%
 imshow(img);
%MENAMPILKAN UKURAN CITRA%
ukuran = size (img);
[baris,kolom,z] = size (img);
%MENGKONVERSI CITRA WARNA KE GRAYSCALE%
gray = rgb2gray(img);
  imshow(gray);
%MENGKONVERSI CITRA GRAYSCALE KE BINER%/
bw = im2bw (gray);
 imshow(bw);

 subplot(1,3,1), imshow(img);title('Citra Asli');
 subplot(1,3,2), imshow(gray);title('Citra Grayscale');
 subplot(1,3,3), imshow(bw);title('Citra Biner');

%MENYIMPAN CITRA%
imwrite(img, 'bangunanrgb.png');
imwrite(gray, 'bangunangray.png');
imwrite(bw, 'bangunanbw.png');
