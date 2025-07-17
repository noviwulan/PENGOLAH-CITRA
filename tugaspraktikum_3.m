% Tugas Praktikum 3%

% Memuat package yang dibutuhkan histogram
 pkg load image;


## 1. MEMBACA CITRA ASLI DAN HISTOGRAMNYA
img_fotoku = imread('C:\Users\WINDOWS 10\Documents\PENGOLAHAN CITRA\praktikum\gambarcitra\fotoku.jpg');


## 2. MEMBANGKITKAN DERAU
% Gaussian Noise
img_gaussian = imnoise(img_fotoku, 'gaussian', 0, 0.01);
% Poisson Noise
img_poisson = imnoise(img_fotoku, 'poisson');
% Salt & Pepper Noise
img_sap = imnoise(img_fotoku, 'salt & pepper', 0.02); % 2% noise
% Speckle Noise (multiplicative Gaussian noise)
noise_speckle = img_fotoku + img_fotoku .* randn(size(img_fotoku)) * 0.2;
img_speckle = im2double(mat2gray(noise_speckle)); % normalisasi ulang
%Quantization Noise (manual)
img_fotoku = im2double(img_fotoku);
levels = 16;
step = 1 / levels;
img_quant = floor(img_fotoku / step) * step + step / 2;


## 3. MENYIMPAN CITRA
imwrite(img_gaussian, 'fotoku_gaussian.jpg');
imwrite(img_poisson, 'fotoku_poisson.jpg');
imwrite(img_sap, 'fotoku_sap.jpg');
imwrite(img_speckle, 'fotoku_speckle.jpg');
imwrite(img_quant, 'fotoku_quant.jpg');

## 4. SIMPAN GAMBAR KE DALAM CELL ARRAY
F1 = img_gaussian;
F2 = img_poisson;
F3 = img_sap;
F4 = img_speckle;
F5 = img_quant;

gambar_asli = {F1, F2, F3, F4, F5};
nama_gambar = {
    'Gaussian Noise',
    'Poisson Noise',
    'Salt Pepper Noise',
    'Speckle Noise',
    'Quantization Noise',

};

## 5. FILTER BATAS
for i = 1:5
    img = gambar_asli{i};
    if ndims(img) == 3
        img = rgb2gray(img);
    end
    [tinggi, lebar] = size(img);
    G = img;
    for baris = 2:tinggi-1
        for kolom = 2:lebar-1
            neighbor = [img(baris-1, kolom-1), img(baris-1, kolom), img(baris-1, kolom+1), ...
                        img(baris, kolom-1), img(baris, kolom+1), ...
                        img(baris+1, kolom-1), img(baris+1, kolom), img(baris+1, kolom+1)];
            minPiksel = min(neighbor);
            maksPiksel = max(neighbor);
            if img(baris, kolom) < minPiksel
                G(baris, kolom) = minPiksel;
            elseif img(baris, kolom) > maksPiksel
                G(baris, kolom) = maksPiksel;
            end
        end
    end

    figure(i); % Figure 1–5
    subplot(2,2,1); imshow(img); title(['Sebelum - ' nama_gambar{i}]);
    subplot(2,2,2); imshow(G); title('Sesudah (Batas)');
    subplot(2,2,3); imhist(img); title('Histogram Sebelum');
    subplot(2,2,4); imhist(G); title('Histogram Sesudah');
end

## 6. FILTER PERERATAAN
for i = 1:5
    img = gambar_asli{i};
    if ndims(img) == 3
        img = rgb2gray(img);
    end
    [tinggi, lebar] = size(img);
    G = zeros(tinggi, lebar);
    img_double = double(img);
    for baris = 2:tinggi-1
        for kolom = 2:lebar-1
            blok = img_double(baris-1:baris+1, kolom-1:kolom+1);
            G(baris, kolom) = mean(blok(:));
        end
    end
    G = uint8(G);

    figure(i + 5); % Figure 6–10
    subplot(2,2,1); imshow(img); title(['Sebelum - ' nama_gambar{i}]);
    subplot(2,2,2); imshow(G); title('Sesudah (Perataan)');
    subplot(2,2,3); imhist(img); title('Histogram Sebelum');
    subplot(2,2,4); imhist(G); title('Histogram Sesudah');
end

## 7. FILTER MEDIAN
for i = 1:5
    img = gambar_asli{i};
    if ndims(img) == 3
        img = rgb2gray(img);
    end
    [tinggi, lebar] = size(img);
    G = img;

    for baris = 2:tinggi-1
        for kolom = 2:lebar-1
            blok = [
                img(baris-1, kolom-1), img(baris-1, kolom), img(baris-1, kolom+1), ...
                img(baris, kolom-1),   img(baris, kolom),   img(baris, kolom+1), ...
                img(baris+1, kolom-1), img(baris+1, kolom), img(baris+1, kolom+1)
            ];
            blok = sort(blok);
            G(baris, kolom) = blok(5);  % Median
        end
    end

    figure(i + 10); % Figure 11–15
    subplot(2,2,1); imshow(img); title(['Sebelum - ' nama_gambar{i}]);
    subplot(2,2,2); imshow(G); title('Sesudah (Median)');
    subplot(2,2,3); imhist(img); title('Histogram Sebelum');
    subplot(2,2,4); imhist(G); title('Histogram Sesudah');
end






