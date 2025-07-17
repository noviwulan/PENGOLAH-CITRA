import os
import cv2
import numpy as np                                          #untuk manipulasi array dan perhitungan matematis.
from sklearn.metrics.pairwise import euclidean_distances    #untuk menghitung jarak antara dua vektor fitur
import matplotlib.pyplot as plt                             #untuk menampilkan gambar dan histogram

# Fungsi untuk mengambil fitur warna rata-rata RGB
def extract_features(image_path):                           
    img = cv2.imread(image_path)                            # Baca gambar dari path
    img = cv2.resize(img, (100, 100))                       # Ubah ukuran gambar ke 100x100 pixel
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)              # Ubah format warna dari BGR ke RGB
    mean_color = np.mean(img.reshape(-1, 3), axis=0)        # Hitung rata-rata warna RGB
    return mean_color                                       # Kembalikan fitur warna (R, G, B)

# Load seluruh citra dari folder nastar
def load_dataset(dataset_path):     #kata kunci 
    features = []                   #menampung fitur gambar 
    labels = []                     #menyimpan label setiap gambar
    paths = []                      #Menyimpan lokasi lengkap gambar

    #Melakukan iterasi untuk setiap kelas (label) kematangan nastar
    for label in ['mentah', 'matang', 'gosong']:
        label_path = os.path.join(dataset_path, label)
        for filename in os.listdir(label_path):
            if filename.lower().endswith(('.jpg', '.jpeg', '.png')):    #EKSTENSI GAMBAR YANG DIPILIH
                file_path = os.path.join(label_path, filename)
                feat = extract_features(file_path)
                features.append(feat)
                labels.append(label)
                paths.append(file_path)
    #Mengembalikan semua data fitur sebagai array, dan label serta path sebagai list.
    return np.array(features), labels, paths

# Tampilkan hasil prediksi dan histogram warna
def show_result(query_img_path, match_img_path, label):
    query_img = cv2.cvtColor(cv2.imread(query_img_path), cv2.COLOR_BGR2RGB)
    match_img = cv2.cvtColor(cv2.imread(match_img_path), cv2.COLOR_BGR2RGB)

    #Membuat tampilan 2 baris dan 2 kolom 
    fig, axs = plt.subplots(2, 2, figsize=(12, 8))

    # Gambar Query
    axs[0, 0].imshow(query_img)         #Tampilkan gambar query di kiri atas.
    axs[0, 0].set_title("Query")
    axs[0, 0].axis('off')

    # Gambar paling mirip dari dataset
    axs[0, 1].imshow(match_img)         #Tampilkan gambar yang paling mirip di kanan atas.
    axs[0, 1].set_title(f"Paling Mirip: {label}")
    axs[0, 1].axis('off')

    # Histogram warna RGB untuk Query
    for i, color in enumerate(['r', 'g', 'b']):     #Buat histogram warna RGB dari gambar query di kiri bawah.
        axs[1, 0].hist(query_img[..., i].ravel(), bins=256, color=color, alpha=0.5)
    axs[1, 0].set_title("Histogram Warna - Query")

    # Histogram warna RGB untuk Match
    for i, color in enumerate(['r', 'g', 'b']): #Buat histogram warna RGB dari gambar hasil prediksi di kanan bawah.
        axs[1, 1].hist(match_img[..., i].ravel(), bins=256, color=color, alpha=0.5)
    axs[1, 1].set_title("Histogram Warna - Paling Mirip")

    #Atur layout agar tidak saling tumpang tindih dan tampilkan semua grafik.
    plt.tight_layout()
    plt.show()



################################# Main program  ########################################

#Tentukan lokasi dataset dan gambar query
if __name__ == "__main__":
    dataset_path = "nastar"               # Folder berisi subfolder: mentah, matang, gosong
    query_img_path = "query-2.jpg"           # Gambar query

    dataset_features, labels, paths = load_dataset(dataset_path)    #Load fitur dan label dari dataset
    query_feature = extract_features(query_img_path).reshape(1, -1) #Ekstrak fitur dari gambar query

    # Hitung jarak Euclidean ke seluruh gambar di dataset
    dists = euclidean_distances(query_feature, dataset_features) #Hitung jarak Euclidean dari query ke semua gambar dataset
    idx = np.argmin(dists)                                       #Ambil indeks gambar dengan jarak terdekat

    # Tampilkan hasil prediksi dan histogram
    threshold = 20 # Batas toleransi jarak (semakin kecil = lebih ketat)
    print(f"Jarak terdekat: {dists[0][idx]:.2f}")

    if dists[0][idx] > threshold:
        print("Gambar tidak dikenali sebagai nastar.")
    else: print(f"Prediksi tingkat kematangan: {labels[idx]}"); show_result(query_img_path, paths[idx], labels[idx])

    
   
