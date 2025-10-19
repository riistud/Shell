# Definisi warna untuk tampilan teks
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Tentukan lisensi yang valid
VALID_LICENSE="riiganteng"

# Path file lisensi dan file kesalahan
LICENSE_FILE="/var/www/pterodactyl/license.txt"
ERROR_FILE="/var/www/pterodactyl/error_count.txt"

# Fungsi untuk memuat konfigurasi
load_config() {
    if [ -f /var/www/pterodactyl/config/installer_config ]; then
        source /var/www/pterodactyl/config/installer_config
    else
        DISABLE_ANIMATIONS=0
    fi
}

# Fungsi untuk menyimpan konfigurasi
save_config() {
    echo "DISABLE_ANIMATIONS=${DISABLE_ANIMATIONS}" > /var/www/pterodactyl/config/installer_config
}

# Fungsi untuk menampilkan teks dengan atau tanpa animasi
animate_text() {
    local text="$1"
    if [ "$DISABLE_ANIMATIONS" -eq 1 ]; then
        echo "$text"
    else
        for ((i=0; i<${#text}; i++)); do
            echo -en "${text:$i:1}"
            sleep 0.05
        done
        echo ""
    fi
}

# Fungsi untuk menampilkan animasi loading
loading_animation() {
    if [ "$DISABLE_ANIMATIONS" -eq 1 ]; then
        echo "LOADING..."
        sleep 1
        return
    fi
    local delay=0.2
    local spinstr='|/-\'
    local loading_text="LOADING..."
    local i=0
    while [ $i -lt ${#loading_text} ]; do
        local temp=${spinstr#?}
        printf " [%c] %s" "$spinstr" "${loading_text:0:i+1}"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\r"
        i=$((i + 1))
    done
    sleep 2
    printf "\r\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
}

# Fungsi untuk memeriksa lisensi
is_license_valid() {
    if [[ -f "$LICENSE_FILE" ]]; then
        # Menggunakan 'head -n 1' untuk memastikan hanya baris pertama yang diambil, mengabaikan baris kosong/spasi
        LICENSE_CONTENT=$(head -n 1 "$LICENSE_FILE" | tr -d '[:space:]')
        if [[ "$LICENSE_CONTENT" == "$VALID_LICENSE" ]]; then
            return 0
        fi
    fi
    return 1
}

# Memuat konfigurasi
load_config

# Inisialisasi file kesalahan jika tidak ada
if [[ ! -f "$ERROR_FILE" ]]; then
    echo "0" > "$ERROR_FILE"
fi

# --- Verifikasi Lisensi Otomatis ---

if ! is_license_valid; then
    # Jika file lisensi tidak ada atau isinya salah
    ERROR_COUNT=$(cat "$ERROR_FILE")
    ERROR_COUNT=$((ERROR_COUNT + 1))
    echo "$ERROR_COUNT" > "$ERROR_FILE"

    if [[ $ERROR_COUNT -ge 3 ]]; then
        echo -e "\n${RED}Lisensi tidak valid atau belum dimasukkan! Anda telah gagal 3 kali. Anda akan keluar.${NC}"
        for i in 3 2 1; do
            echo "$i"
            sleep 1
        done
        exit 1
    else
        REMAINING_ATTEMPTS=$((3 - ERROR_COUNT))
        echo -e "\n${RED}Lisensi tidak valid atau belum dimasukkan! Anda telah salah $ERROR_COUNT kali. Sisa $REMAINING_ATTEMPTS kali lagi.${NC}"
    fi
else
    # Reset hitungan kesalahan jika lisensi valid
    echo "0" > "$ERROR_FILE"
fi

# Menampilkan banner
clear
echo -e "
╭━━━┳━━┳━━┳━━━┳━━━━┳━━━┳━━━┳━━━╮
┃╭━╮┣┫┣┻┫┣┫╭━╮┃╭╮╭╮┃╭━╮┃╭━╮┃╭━━╯
┃╰━╯┃┃┃╱┃┃┃╰━━╋╯┃┃╰┫┃╱┃┃╰━╯┃╰━━╮
┃╭╮╭╯┃┃╱┃┃╰━━╮┃╱┃┃╱┃┃╱┃┃╭╮╭┫╭━━╯
┃┃┃╰┳┫┣┳┫┣┫╰━╯┃╱┃┃╱┃╰━╯┃┃┃╰┫╰━━╮
╰╯╰━┻━━┻━━┻━━━╯╱╰╯╱╰━━━┻╯╰━┻━━━╯
"
echo -e "${GREEN}WHATSAPP : 083161246809${NC}"
echo -e "${RED}YOUTUBE : @riistoreid${NC}"
echo ""

animate_text "ANDA SUDAH TERVERIFIKASI, SILAHKAN MASUKAN LICENSE YANG DI BAGI DARI RIISTORE ID"
animate_text "JIKA BELUM PUNYA LICENSE SILAHKAN BELI DI RIISTORE ID , CUMAN 10K DAH FREE UPDATE LICENSE"
animate_text " CONTACT RIISTORE ID: "
echo -e "${RED}WhatsApp: 083161246809${NC}"
echo -e "${RED}Instagram : @fakhriigt${NC}"
echo -e "${GREEN}"

# Minta pengguna memasukkan lisensi
read -p "Masukkan lisensi Anda: " INPUT_LICENSE

# Verifikasi lisensi input pengguna
if [ "$INPUT_LICENSE" != "$VALID_LICENSE" ]; then
    echo -e "\n${RED}LICENSE LU SALAH WOKWOKWOKWOKWOK${NC}"
    for i in 3 2 1; do
        animate_text "$i"
        sleep 1
    done
    exit 1
else
    # Simpan lisensi yang benar jika belum ada/salah di file
    echo "$VALID_LICENSE" > "$LICENSE_FILE"
    echo "0" > "$ERROR_FILE" # Reset error count setelah input manual benar
fi

animate_text "LICENSE ANDA BENAR, TERIMAKASIH TELAH MEMBELI INSTALLER INI,"
animate_text "OPSI ADA DIBAWAH INI"

# Animasi loading
loading_animation
echo -ne "\033[K" # Menghapus teks loading dari baris
sleep 0.5

# Menampilkan menu opsi
clear
echo -e "${BLUE}[+] ============================================== [+]${NC}"
echo -e "${BLUE}[+]              WELCOME TO INSTALLER PREMIUM        [+]${NC}"
echo -e "${BLUE}[+]              VERSI SAAT INI V 5.0                [+]${NC}"
echo -e "${BLUE}[+]              © RII STORE ID.                     [+]${NC}"
echo -e "${BLUE}[+] ============================================== [+]${NC}"
echo ""
echo -e "${BLUE}[+] ============================================== [+]${NC}"
echo "1. INSTALL THEME ELYSIUM PTERODACTYL (FIX)"
echo "2. INSTALL ADDON AUTO SUSPEND PTERODACTYL"
echo "3. INSTALL NEBULA THEME PTERODACTYL (FIX)"
echo "4. UBAH BACKROUND PTERODACTYL"
echo "5. INSTALL GOOGLE ANALITIC PTERODACTYL"
echo "6. ADMIN PANEL THEME PTERODACTYL"
echo "7. ENIGMA PREMIUM PTERODACTYL"
echo "8. HAPUS BACKROUND PTERODACTYL"
echo "9. HAPUS THEME/ADDON"
echo "10. MATIKAN SEMUA ANIMASI INSTALLER"
echo "12. GANTI PW VPS"
echo "13. INSTALL PANEL (FIX)"
echo "14. INSTALL WINGS (FIX)"
echo "15. UNINSTALL PANEL"
echo "16. BUAT NODE PANEL"
echo "17. CONFIGURE WINGS"
echo "20. INSTALL TEMA STELLAR PTERODACTYL"
echo "21. INSTALL TEMA NOOKTHEME PTERODACTYL"
echo "22. AUTO INSTALL PANEL + WINGS (FIX)"
echo "23. KELUAR DARI INSTALLER"
echo -e "${BLUE}[+] ============================================== [+]${NC}"
read -p "PILIH OPSI (1-23): " OPTION
echo ""

case "$OPTION" in
    1)
        # Instalasi Theme Elysium
        GITHUB_TOKEN="GITHUB_TOKEN_PLACEHOLDER_1" # Ganti dengan token Anda
        REPO_URL="https://${GITHUB_TOKEN}@github.com/riistud/TEMA.git"
        TEMP_DIR="TEMA"
        THEME_ZIP="ElysiumTheme.zip"
        
        animate_text "Memulai instalasi Elysium Theme..."

        # Mengkloning repositori
        if git clone "$REPO_URL"; then
            animate_text "Repository berhasil dikloning."
        else
            echo -e "${RED}Gagal mengkloning repository! Pastikan token GitHub valid.${NC}"
            exit 1
        fi

        # Memindahkan dan mengekstrak file
        sudo mv "$TEMP_DIR/$THEME_ZIP" /var/www/
        animate_text "File zip berhasil dipindahkan."

        unzip -o /var/www/$THEME_ZIP -d /var/www/
        rm -r $TEMP_DIR
        rm /var/www/$THEME_ZIP
        animate_text "File berhasil diekstrak dan file sementara dihapus."

        # Persiapan Node.js 16 (Mengikuti skrip asli, meskipun Node.js 20 lebih baru)
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg || true
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
        sudo apt update
        sudo apt install -y nodejs
        apt install -y npm # Tambahkan -y untuk otomatisasi
        animate_text "Node.js dan NPM terinstal."
        
        echo -e "${BLUE} JIKA INSTALL NPM ERROR TETAP AKAN WORK, LANJUTKAN SAJA${NC}"

        # Instalasi dependensi
        npm i -g yarn
        cd /var/www/pterodactyl
        yarn
        yarn build:production
        
        # Perintah Pterodactyl
        echo -e "${BLUE} KETIK yes UNTUK MELANJUTKAN${NC}"
        php artisan migrate
        php artisan view:clear
        animate_text "${GREEN}Tema Elysium berhasil diinstal.${NC}"
        
        # Penanganan Unduhan File Tambahan (Diubah agar tidak menggunakan token secara eksplisit)
        # FILE_URL="https://raw.githubusercontent.com/username/repo/main/path/to/file"
        # DESTINATION="/var/www/pterodactyl/filename"
        # curl -H "Authorization: token ${GITHUB_TOKEN}" -L -o "${DESTINATION}" "${FILE_URL}"

        ;;
    2)
        # Instalasi Addon Auto Suspend
        GITHUB_TOKEN="GITHUB_TOKEN_PLACEHOLDER_2" # Ganti dengan token Anda
        REPO_URL="https://${GITHUB_TOKEN}@github.com/riistud/TEMA.git"
        TEMP_DIR="TEMA"
        ADDON_ZIP="autosuspens.zip"

        animate_text "Memulai instalasi Auto Suspend Addon..."

        if git clone "$REPO_URL"; then
             animate_text "Repository berhasil dikloning."
        else
             echo -e "${RED}Gagal mengkloning repository! Pastikan token GitHub valid.${NC}"
             exit 1
        fi

        sudo mv "$TEMP_DIR/$ADDON_ZIP" /var/www/

        unzip -o /var/www/$ADDON_ZIP -d /var/www/
        rm -r $TEMP_DIR
        rm /var/www/$ADDON_ZIP

        cd /var/www/pterodactyl
        # Jalankan installer bash
        if [ -f installer.bash ]; then
            bash installer.bash
            animate_text "${GREEN}AUTO SUSPEND BERHASIL DIINSTALL${NC}"
        else
            echo -e "${RED}File installer.bash tidak ditemukan di /var/www/pterodactyl.${NC}"
            exit 1
        fi

        # Penanganan Unduhan File Tambahan (Diubah agar tidak menggunakan token secara eksplisit)
        # ...
        ;;
    3)
        # Instalasi Nebula Theme (Menggunakan Blueprint Framework)
        GITHUB_TOKEN="GITHUB_TOKEN_PLACEHOLDER_3" # Ganti dengan token Anda
        REPO_URL="https://${GITHUB_TOKEN}@github.com/riistud/TEMA.git"
        TEMP_DIR="TEMA"

        animate_text "Memulai instalasi Nebula Theme..."

        # Instalasi dependensi (Node.js 20)
        sudo apt-get install -y ca-certificates curl gnupg
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
        sudo apt-get update
        sudo apt-get install -y nodejs
        npm i -g yarn
        cd /var/www/pterodactyl
        yarn
        yarn add cross-env
        sudo apt install -y zip unzip git curl wget
        animate_text "Dependensi terinstal."

        # Instalasi Blueprint Framework
        if wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | cut -d '"' -f 4)" -O /var/www/pterodactyl/release.zip; then
            cd /var/www/pterodactyl
            unzip -o release.zip
            rm release.zip
            chmod +x blueprint.sh
            bash blueprint.sh
            animate_text "Blueprint Framework terinstal."
        else
            echo -e "${RED}Gagal mengunduh Blueprint Framework.${NC}"
            exit 1
        fi

        # Mendapatkan file tema
        cd /var/www/
        if git clone "$REPO_URL"; then
            sudo mv "$TEMP_DIR/nebulaptero.zip" /var/www/
        else
            echo -e "${RED}Gagal mengkloning repository! Pastikan token GitHub valid.${NC}"
            exit 1
        fi
        
        unzip -o /var/www/nebulaptero.zip -d /var/www/
        
        # Instalasi Nebula
        cd /var/www/pterodactyl && blueprint -install nebula
        
        # Cleanup
        cd /var/www/ && rm -r $TEMP_DIR
        cd /var/www/ && rm -f nebulaptero.zip
        cd /var/www/pterodactyl && rm -f nebula.blueprint
        
        animate_text "${GREEN}NEBULA THEME BERHASIL DI INSTALL${NC}"
        
        # Penanganan Unduhan File Tambahan (Diubah agar tidak menggunakan token secara eksplisit)
        # ...
        ;;
    4)
        # Ubah Background Pterodactyl
        DEFAULT_URL="https://telegra.ph/file/28c25edd617126d1056d9.jpg"
        read -p "Masukkan URL gambar (tekan Enter untuk menggunakan URL default): " USER_URL

        if [ -z "$USER_URL" ]; then
            URL="$DEFAULT_URL"
        else
            URL="$USER_URL"
        fi

        cd /var/www/pterodactyl/resources/views/templates || { echo -e "${RED}Direktori tidak ditemukan.${NC}"; exit 1; }

        if grep -q 'background-image' wrapper.blade.php; then
            echo "APAKAH ANDA SUDAH MENGHAPUS BACKGROUND ANDA SEBELUM MEMASANG?"
            read -p "JIKA BELUM PERNAH / SUDAH Ketik y, JIKA BELUM KETIK n: " CONFIRM

            if ! [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
                echo -e "${RED}SILAHKAN HAPUS TERLEBIH DAHULU (Opsi 8)${NC}"
                exit 1
            fi
        fi

        # Membuat konten HTML baru
        {
            echo '<!DOCTYPE html>'
            echo '<html lang="en">'
            echo '<head>'
            echo '    <meta charset="UTF-8">'
            echo '    <meta name="viewport" content="width=device-width, initial-scale=1.0">'
            echo '    <title>Pterodactyl Background</title>'
            echo '    <style>'
            echo "        body {"
            echo "            background-image: url('$URL');"
            echo '            background-size: cover;'
            echo '            background-repeat: no-repeat;'
            echo '            background-attachment: fixed;'
            echo '            margin: 0;'
            echo '            padding: 0;'
            echo '        }'
            echo '    </style>'
            echo '</head>'
            echo '<body>'
            echo '    '
            echo '</body>'
            echo '</html>'
            echo ''
            
            # Mendapatkan konten wrapper.blade.php asli, dan menimpanya dengan isi baru, yang menyertakan style background
            # Perhatikan: Logic ini menggabungkan HTML dasar dengan style, dan kemudian menempelkan isi wrapper.blade.php yang ada.
            # Ini mungkin bukan cara yang benar untuk memodifikasi blade template. Untuk perbaikan, ini hanya menyalin logic skrip asli.
            cat wrapper.blade.php 
        } > /tmp/new_wrapper.blade.php

        sudo mv /tmp/new_wrapper.blade.php wrapper.blade.php

        echo -e "${BLUE}BACKGROUND BERHASIL DI GANTI${NC}"
        ;;
    5)
        # Instalasi Google Analytic
        GITHUB_TOKEN="GITHUB_TOKEN_PLACEHOLDER_4" # Ganti dengan token Anda
        REPO_URL="https://${GITHUB_TOKEN}@github.com/riistud/TEMA.git"
        TEMP_DIR="TEMA"
        ADDON_ZIP="googleanalitic.zip"
        
        animate_text "Memulai instalasi Google Analytic Addon..."

        if git clone "$REPO_URL"; then
            animate_text "Repository berhasil dikloning."
        else
            echo -e "${RED}Gagal mengkloning repository! Pastikan token GitHub valid.${NC}"
            exit 1
        fi

        sudo mv "$TEMP_DIR/$ADDON_ZIP" /var/www/

        unzip -o /var/www/$ADDON_ZIP -d /var/www/
        rm -r $TEMP_DIR
        rm /var/www/$ADDON_ZIP
        
        # Persiapan Node.js 16 (Mengikuti skrip asli)
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg || true
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
        sudo apt update
        sudo apt install -y nodejs
        apt install -y npm
        echo -e "${BLUE} JIKA INSTALL NPM ERROR TETAP AKAN WORK, LANJUTKAN SAJA${NC}"

        # Instalasi dependensi
        npm i -g yarn
        cd /var/www/pterodactyl
        yarn
        yarn build:production
        
        # Perintah Pterodactyl
        echo -e "${BLUE} KETIK yes UNTUK MELANJUTKAN${NC}"
        php artisan migrate
        php artisan view:clear
        animate_text "${BLUE}ADDON GOOGLE ANALITYC BERHASIL DIINSTAL${NC}"

        # Penanganan Unduhan File Tambahan (Diubah agar tidak menggunakan token secara eksplisit)
        # ...
        ;;
    6)
        # Instalasi Admin Panel Theme (Slate)
        GITHUB_TOKEN="GITHUB_TOKEN_PLACEHOLDER_5" # Ganti dengan token Anda
        REPO_URL="https://${GITHUB_TOKEN}@github.com/riistud/TEMA.git"
        TEMP_DIR="TEMA"
        THEME_ZIP="Slate-v1.0.zip"
        
        animate_text "Memulai instalasi Slate Admin Theme..."

        # Instalasi dependensi (Node.js 20)
        sudo apt-get install -y ca-certificates curl gnupg
        sudo mkdir -p /etc/apt/keyrings
        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
        sudo apt-get update
        sudo apt-get install -y nodejs
        npm i -g yarn
        cd /var/www/pterodactyl
        yarn
        yarn add cross-env
        sudo apt install -y zip unzip git curl wget
        animate_text "Dependensi terinstal."

        # Instalasi Blueprint Framework
        if wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | cut -d '"' -f 4)" -O /var/www/pterodactyl/release.zip; then
            cd /var/www/pterodactyl
            unzip -o release.zip
            rm release.zip
            chmod +x blueprint.sh
            bash blueprint.sh
            animate_text "Blueprint Framework terinstal."
        else
            echo -e "${RED}Gagal mengunduh Blueprint Framework.${NC}"
            exit 1
        fi

        # Mendapatkan file tema
        cd /var/www/
        if git clone "$REPO_URL"; then
            sudo mv "$TEMP_DIR/$THEME_ZIP" /var/www/
        else
            echo -e "${RED}Gagal mengkloning repository! Pastikan token GitHub valid.${NC}"
            exit 1
        fi
        
        unzip -o /var/www/$THEME_ZIP -d /var/www/
        
        # Instalasi Slate
        cd /var/www/pterodactyl && blueprint -install slate
        
        # Cleanup
        cd /var/www/ && rm -r $TEMP_DIR
        cd /var/www/ && rm -f $THEME_ZIP
        
        animate_text "${GREEN}SLATE ADMIN THEME BERHASIL DI INSTALL${NC}"
        
        # Penanganan Unduhan File Tambahan (Diubah agar tidak menggunakan token secara eksplisit)
        # ...
        ;;
    7)
        # Instalasi Enigma Premium
        GITHUB_TOKEN="GITHUB_TOKEN_PLACEHOLDER_6" # Ganti dengan token Anda
        REPO_URL="https://${GITHUB_TOKEN}@github.com/riistud/TEMA.git"
        TEMP_DIR="TEMA"

        show_loading() {
            echo -n "[-] LOADING"
            for i in {1..3}; do
                sleep 0.5
                echo -n "."
            done
            echo ""
        }

        animate_text "Memulai instalasi Enigma Premium..."
        show_loading
        
        # Instalasi dependensi (Node.js 20)
        echo -e "${BLUE}JIKA ADA PILIHAN SILAHKAN KETIK y${NC}"
        sudo mkdir -p /etc/apt/keyrings >/dev/null 2>&1
        curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg >/dev/null 2>&1
        show_loading
        echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list >/dev/null 2>&1
        sudo apt-get update >/dev/null 2>&1
        sudo apt-get install -y nodejs npm zip unzip git curl wget >/dev/null 2>&1
        npm i -g yarn >/dev/null 2>&1
        cd /var/www/pterodactyl
        yarn >/dev/null 2>&1
        
        # Mendapatkan file tema
        cd /var/www/
        git clone "$REPO_URL" "$TEMP_DIR" >/dev/null 2>&1
        
        cd "$TEMP_DIR"
        sudo mv enigmarimake.zip /var/www/
        cd /var/www/
        unzip -o enigmarimake.zip -d /var/www/ >/dev/null 2>&1
        rm -r "$TEMP_DIR" enigmarimake.zip

        # Ganti nomor WhatsApp
        nomor_lama="6283161246809"
        read -p "MASUKAN NOMOR WHATSAPP ANDA ( ISI MENGGUNAKAN AWALAN CODE NOMOR EXAMPLE : 6283161246809 ) : " nomor_baru

        if ! [[ "$nomor_baru" =~ ^[0-9]+$ ]]; then
            echo -e "${RED}Nomor baru harus berupa angka. Silakan coba lagi.${NC}"
            exit 1
        fi

        file_path="/var/www/pterodactyl/resources/scripts/components/dashboard/DashboardContainer.tsx"
        if [ -f "$file_path" ]; then
            sudo sed -i "s/$nomor_lama/$nomor_baru/g" "$file_path"
            echo "OWNER > $nomor_baru"
        else
            echo -e "${RED}File DashboardContainer.tsx tidak ditemukan.${NC}"
            exit 1
        fi

        # Ubah Background Theme (Logic yang sama dengan Opsi 4)
        read -p "APAKAH ANDA INGIN MENGUBAH LATAR BELAKANG (BACKGROUND) DARI THEME INI? (KETIK y UNTUK MENGUBAH DAN KETIK n UNTUK MEMAKAI DEFAULT) (y/n) " ubah_theme
        show_loading
        if [[ "$ubah_theme" =~ ^[Yy]$ ]]; then
            # (Logic ubah background Opsi 4 diulang di sini)
            DEFAULT_URL="https://telegra.ph/file/28c25edd617126d1056d9.jpg"
            read -p "Masukkan URL gambar (tekan Enter untuk menggunakan URL default): " USER_URL
            URL=${USER_URL:-$DEFAULT_URL}

            cd /var/www/pterodactyl/resources/views/templates || exit
            if grep -q 'background-image' wrapper.blade.php; then
                read -p "APAKAH ANDA SUDAH MENGHAPUS BACKGROUND ANDA SEBELUM MEMASANG? (y/n) " CONFIRM
                if ! [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
                    echo -e "${RED}SILAHKAN HAPUS TERLEBIH DAHULU (Opsi 8)${NC}"
                    exit 1
                fi
            fi

            # Membuat konten HTML baru (sama seperti Opsi 4)
            {
                echo '<!DOCTYPE html>'
                echo '<html lang="en">'
                echo '<head>'
                echo '    <meta charset="UTF-8">'
                echo '    <meta name="viewport" content="width=device-width, initial-scale=1.0">'
                echo '    <title>Pterodactyl Background</title>'
                echo '    <style>'
                echo "        body {"
                echo "            background-image: url('$URL');"
                echo '            background-size: cover;'
                echo '            background-repeat: no-repeat;'
                echo '            background-attachment: fixed;'
                echo '            margin: 0;'
                echo '            padding: 0;'
                echo '        }'
                echo '    </style>'
                echo '</head>'
                echo '<body>'
                echo '    '
                echo '</body>'
                echo '</html>'
                echo ''
                cat wrapper.blade.php
            } > /tmp/new_wrapper.blade.php

            sudo mv /tmp/new_wrapper.blade.php wrapper.blade.php
            echo -e "${BLUE}BACKGROUND BERHASIL DI GANTI${NC}"
        else
            echo "Anda memilih untuk tidak mengubah background theme."
        fi

        # Ubah Copyright Name
        read -p "APAKAH ANDA INGIN MENGUBAH COPYRIGHT NAME? (y/n) : " ubah_copyright
        show_loading
        if [[ "$ubah_copyright" =~ ^[Yy]$ ]]; then
            read -p "MASUKAN NAMA ANDA / NAMA STORE ANDA : " copyright_baru
            show_loading

            file_path_copyright="/var/www/pterodactyl/resources/scripts/components/auth/LoginFormContainer.tsx"

            if [ -f "$file_path_copyright" ]; then
                sudo sed -i "s/LEXCZXMODZ/$copyright_baru/g" "$file_path_copyright"
                echo "COPYRIGHT NAME BERHASIL DI UBAH MENJADI $copyright_baru"
            else
                echo -e "${RED}File copyright login tidak ditemukan.${NC}"
            fi
        else
            echo "Anda memilih untuk tidak mengubah copyright login."
        fi

        # Ubah Link Copyright
        while true; do
            read -p "APAKAH ANDA INGIN MENGUBAH LINK COPYRIGHT (MAKSUDNYA ADALAH: JIKA KAMU MENGKLIK $copyright_baru OTOMATIS AKAN KE LINK YANG ANDA MASUKIN DISINI CONTOHNYA KE WHASTAPP: https://wa.me/6287743212449 HARUS MEMAKAI https:// DI DEPANNYA YA) (y/n) : " ubah_link
            show_loading
            if [[ "$ubah_link" =~ ^[Yy]$ ]]; then
                read -p "MASUKAN LINK SOCIAL: " link_baru
                show_loading

                if ! [[ "$link_baru" =~ ^https:// ]]; then
                    echo "${RED}HARUS MEMAKAI https://${NC}"
                    continue
                fi

                file_path_link="/var/www/pterodactyl/resources/scripts/components/auth/LoginFormContainer.tsx"

                if [ -f "$file_path_link" ]; then
                    # Mengganti placeholder link yang tidak pantas (pornhub.com) dengan link baru
                    sudo sed -i "s|https:\/\/pornhub\.com|$link_baru|g" "$file_path_link"
                    echo "LINK COPYRIGHT BERHASIL DI UBAH MENJADI $link_baru"
                    break
                else
                    echo "${RED}File copyright link Login Tidak Di Temukan${NC}"
                    break
                fi
            else
                echo "ANDA MEMILIH UNTUK TIDAK MENGAKTIFKAN, BAIKLAH"
                break
            fi
        done

        # Membangun produksi
        cd /var/www/pterodactyl && npx update-browserslist-db@latest >/dev/null 2>&1 && export NODE_OPTIONS=--openssl-legacy-provider && yarn build:production >/dev/null 2>&1

        animate_text "${GREEN}PROSES SELESAI${NC}"
        ;;
    8)
        # Hapus Background Pterodactyl (Mengembalikan wrapper.blade.php ke default)
        file_path="/var/www/pterodactyl/resources/views/templates/wrapper.blade.php"

        # Konten asli wrapper.blade.php (dipersingkat untuk brevity)
        cat << 'EOF' | sudo tee "$file_path" > /dev/null
<!DOCTYPE html>
<html>
    <head>
        <title>{{ config('app.name', 'Pterodactyl') }}</title>

        @section('meta')
            <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
            <meta name="csrf-token" content="{{ csrf_token() }}">
            <meta name="robots" content="noindex">
            <link rel="apple-touch-icon" sizes="180x180" href="/favicons/apple-touch-icon.png">
            <link rel="icon" type="image/png" href="/favicons/favicon-32x32.png" sizes="32x32">
            <link rel="icon" type="image/png" href="/favicons/favicon-16x16.png" sizes="16x16">
            <link rel="manifest" href="/favicons/manifest.json">
            <link rel="mask-icon" href="/favicons/safari-pinned-tab.svg" color="#bc6e3c">
            <link rel="shortcut icon" href="/favicons/favicon.ico">
            <meta name="msapplication-config" content="/favicons/browserconfig.xml">
            <meta name="theme-color" content="#0e4688">
        @show

        @section('user-data')
            @if(!is_null(Auth::user()))
                <script>
                    window.PterodactylUser = {!! json_encode(Auth::user()->toVueObject()) !!};
                </script>
            @endif
            @if(!empty($siteConfiguration))
                <script>
                    window.SiteConfiguration = {!! json_encode($siteConfiguration) !!};
                </script>
            @endif
        @show
        <style>
            @import url('//fonts.googleapis.com/css?family=Rubik:300,400,500&display=swap');
            @import url('//fonts.googleapis.com/css?family=IBM+Plex+Mono|IBM+Plex+Sans:500&display=swap');
        </style>

        @yield('assets')

        @include('layouts.scripts')

        <script async src="https://www.googletagmanager.com/gtag/js?id={{ config('app.google_analytics', 'Pterodactyl') }}"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());

            gtag('config', '{{ config('app.google_analytics', 'Pterodactyl') }}');
        </script>
    </head>
    <body class="{{ $css['body'] ?? 'bg-neutral-50' }}">
        @section('content')
            @yield('above-container')
            @yield('container')
            @yield('below-container')
        @show
        @section('scripts')
            {!! $asset->js('main.js') !!}
        @show
    </body>
</html>
EOF

        if [ $? -eq 0 ]; then
            echo -e "${GREEN}BACKROUND ANDA BERHASIL DI HAPUS${NC}"
        else
            echo -e "${RED}TERJADI KESALAHAN SAAT MEMPERBARUI FILE!! SILAHKAN HUBUNGI 085263390832 UNTUK MEMINTA BANTUAN${NC}"
        fi
        ;;
    9)
        # Hapus Theme/Addon (Menginstal ulang file panel inti)
        animate_text "HAPUS THEME/ADDON DIPILIH. Memulai instalasi ulang file panel inti..."
        
        cd /var/www/pterodactyl || { echo -e "${RED}Direktori Pterodactyl tidak ditemukan.${NC}"; exit 1; }
        
        php artisan down
        
        # Unduh dan ekstrak panel inti Pterodactyl
        curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | sudo tar -xzv -f -

        # Setel izin
        sudo chmod -R 755 storage/* bootstrap/cache
        
        # Instal dependensi composer
        animate_text "Menjalankan Composer..."
        sudo composer install --no-dev --optimize-autoloader
        
        # Bersihkan cache
        php artisan view:clear
        php artisan config:clear
        
        # Migrasi database
        animate_text "Menjalankan Migrasi Database..."
        php artisan migrate --seed --force
        
        # Setel kepemilikan
        sudo chown -R www-data:www-data /var/www/pterodactyl/*
        
        php artisan up
        
        animate_text "${GREEN}Semua tema dan addon telah dihapus dan panel dikembalikan ke default.${NC}"
        ;;
    10)
        # Matikan Animasi
        DISABLE_ANIMATIONS=1
        save_config
        echo -e "${YELLOW}Semua animasi telah dimatikan.${NC}"
        ;;
    12)
        # Ganti Password VPS
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        echo -e "${GREEN}[+]              UBAH PASSWORD VPS                    [+]${NC}"
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        read -s -p "Masukkan Pw Baru: " pw1
        echo
        read -s -p "Masukkan Ulang Pw Baru: " pw2
        echo

        if [ "$pw1" != "$pw2" ]; then
            echo -e "${RED}Password tidak cocok. Pembatalan.${NC}"
            exit 1
        fi
        
        if echo -e "$pw1\n$pw2" | passwd; then
            echo -e "${GREEN}[+] =============================================== [+]${NC}"
            echo -e "${GREEN}[+]              GANTI PW VPS SUKSES                  [+]${NC}"
            echo -e "${GREEN}[+] =============================================== [+]${NC}"
        else
            echo -e "${RED}Gagal mengganti password VPS.${NC}"
        fi
        sleep 2
        exit 0
        ;;
    13)
        # Instalasi Panel (Menggunakan pterodactyl-installer.se)
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        echo -e "${GREEN}[+]               AUTO INSTALL PANEL                  [+]${NC}"
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        
        read -p "Masukkan Nama : " nama
        read -s -p "Masukkan Password : " pw
        echo
        read -p "Masukkan Subdomain : " subdo

        # Menjalankan installer dengan input otomatis
        bash <(curl -s https://pterodactyl-installer.se) <<EOF
0
$nama
$nama
$pw
Asia/Jakarta
admin@riistore.com
admin@riistore.com
$nama
$nama
$nama
$pw
$subdo
y
y
y
y
yes
Y
EOF

        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        echo -e "${GREEN}[+]             AUTO INSTALL SUKSES.                  [+]${NC}"
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        sleep 2
        exit 0
        ;;
    14)
        # Instalasi Wings (Menggunakan pterodactyl-installer.se)
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        echo -e "${GREEN}[+]               AUTO INSTALL WINGS                  [+]${NC}"
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        
        read -p "Masukan nama pas install panel : " user
        read -s -p "Masukkan Password : " pw
        echo
        read -p "Masukkan Link Panel Tanpa https:// : " subdo
        read -p "Masukkan NodeSubdomain Contoh (node.panel.com) : " nodesubdo
        
        # Menjalankan installer dengan input otomatis
        bash <(curl -s https://pterodactyl-installer.se) <<EOF
1
y
y
y
$subdo
y
$user
$pw
y
$nodesubdo
y
admin@riistore.com
y
EOF

        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        echo -e "${GREEN}[+]             AUTO INSTALL WINGS SUKSES             [+]${NC}"
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        sleep 2
        exit 0
        ;;
    15)
        # Uninstall Panel (Menggunakan pterodactyl-installer.se)
        echo -e "${BLUE}[+] =============================================== [+]${NC}"
        echo -e "${BLUE}[+]              UNINSTALL PANEL                      [+]${NC}"
        echo -e "${BLUE}[+] =============================================== [+]${NC}"
        
        read -p "Uninstall Panel (y/n): " ypanel
        read -p "Uninstall Wings (y/n): " ywings
        
        # Menjalankan installer dengan input otomatis
        bash <(curl -s https://pterodactyl-installer.se) <<EOF
6
$ypanel
$ywings
y
y
EOF

        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        echo -e "${GREEN}[+]             UNINSTALL PANEL SUKSES                [+]${NC}"
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        sleep 2
        clear
        exit 0
        ;;
    16)
        # Buat Node Panel (Menggunakan Artisan CLI)
        echo -e "${BLUE}[+] =============================================== [+]${NC}"
        echo -e "${BLUE}[+]                CREATE NODE                        [+]${NC}"
        echo -e "${BLUE}[+] =============================================== [+]${NC}"

        validate_input() {
            if [[ -z "$1" ]]; then
                echo -e "${RED}Error: $2 tidak boleh kosong.${NC}"
                exit 1
            fi
        }

        read -p "Masukkan nama lokasi: " location_name
        validate_input "$location_name" "Nama lokasi"

        read -p "Masukkan deskripsi lokasi: " location_description
        validate_input "$location_description" "Deskripsi lokasi"

        read -p "Masukkan domain: " domain
        validate_input "$domain" "Domain"

        read -p "Masukkan nama node: " node_name
        validate_input "$node_name" "Nama node"

        read -p "Masukkan RAM: " ram
        validate_input "$ram" "RAM"

        read -p "Masukkan jumlah maksimum disk space: " disk_space
        validate_input "$disk_space" "Disk space"

        read -p "Masukkan Locid: " locid
        validate_input "$locid" "Locid"

        cd /var/www/pterodactyl || { echo -e "${RED}Direktori tidak ditemukan.${NC}"; exit 1; }

        # Membuat lokasi
        echo -e "$location_name\n$location_description" | php artisan p:location:make
        if [ $? -ne 0 ]; then
             echo -e "${RED}Error: Gagal membuat lokasi.${NC}"
        fi

        # Membuat node
        echo -e "$node_name\n$location_description\n$locid\nhttps\n$domain\nyes\nno\nno\n$ram\n$ram\n$disk_space\n$disk_space\n100\n8080\n2022\n/var/lib/pterodactyl/volumes" | php artisan p:node:make
        if [ $? -ne 0 ]; then
             echo -e "${RED}Error: Gagal membuat node.${NC}"
        fi

        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        echo -e "${GREEN}[+]        CREATE NODE & LOCATION SUKSES              [+]${NC}"
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        exit 0
        ;;
    17)
        # Configure Wings
        echo -e "${BLUE}[+] =============================================== [+]${NC}"
        echo -e "${BLUE}[+]              CONFIGURE WINGS                      [+]${NC}"
        echo -e "${BLUE}[+] =============================================== [+]${NC}"
        
        read -p "Masukkan token Configure untuk menjalankan wings: " wings_command
        
        # Mengeksekusi command token yang diberikan (harap berhati-hati dengan input ini)
        eval "$wings_command"
        
        # Menjalankan wings
        sudo systemctl start wings

        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        echo -e "${GREEN}[+]             CONFIGURE WINGS SUKSES                [+]${NC}"
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        sleep 2
        clear
        exit 0
        ;;
    20)
        # Instalasi Tema Stellar Pterodactyl
        GITHUB_TOKEN="GITHUB_TOKEN_PLACEHOLDER_7" # Ganti dengan token Anda
        REPO_URL="https://${GITHUB_TOKEN}@github.com/rainmc01/RainPrem.git"
        TEMP_DIR="RainPrem"
        STELLAR_ZIP="stellarrimake.zip"
        AUTOSUSPEND_ZIP="autosuspens.zip"

        animate_text "Memulai instalasi Stellar Theme..."

        cd /var/www
        if git clone "$REPO_URL"; then
             animate_text "Repository berhasil dikloning."
        else
             echo -e "${RED}Gagal mengkloning repository! Pastikan token GitHub valid.${NC}"
             exit 1
        fi

        sudo mv "$TEMP_DIR/$STELLAR_ZIP" /var/www/
        sudo mv "$TEMP_DIR/$AUTOSUSPEND_ZIP" /var/www/
        
        sudo rm -r $TEMP_DIR > /dev/null 2>&1
        
        unzip -o /var/www/$STELLAR_ZIP -d /var/www/
        unzip -o /var/www/$AUTOSUSPEND_ZIP -d /var/www/
        
        rm /var/www/$STELLAR_ZIP
        rm /var/www/$AUTOSUSPEND_ZIP
        
        animate_text "Membangun Front-End dan Memperbaiki Jika Error"
        cd /var/www/pterodactyl
        yarn
        yarn add react-feather
        
        if ! yarn build:production; then
            echo -e "${BLUE}Kelihatannya ada kesalahan.. Proses fix..${NC}"
            export NODE_OPTIONS=--openssl-legacy-provider
            yarn
            yarn add react-feather
            npx update-browserslist-db@latest
            yarn build:production
        fi
        
        animate_text "Menjalankan Migrasi dan Membersihkan Cache"
        php artisan migrate --force
        php artisan view:clear
        
        animate_text "Menginstal Addon Auto Suspend"
        cd /var/www/pterodactyl
        if [ -f installer.bash ]; then
            bash installer.bash
        else
            echo -e "${RED}File installer.bash untuk Auto Suspend tidak ditemukan!${NC}"
        fi
        
        clear
        echo -e "${CYAN}============================================================${NC}"
        echo -e "${GREEN}THEME STELLAR BERHASIL TERINSTAL${NC}"
        echo -e "${GREEN}ADDON AUTO SUSPEND BERHASIL DIINSTALL${NC}"
        echo -e "${CYAN}============================================================${NC}"
        ;;
    21)
        # Instalasi Tema NookTheme Pterodactyl
        animate_text "ANDA HARUS MEMILIKI PANEL PTERODACTYL TERLEBIH DAHULU! APAKAH ANDA MEMPUNYAINYA? (YES/NO)"
        read -r HAS_PTERODACTYL

        if [[ "$HAS_PTERODACTYL" =~ ^(YES|yes)$ ]]; then
            animate_text "APAKAH ANDA SUDAH MENGHAPUS SEMUA THEME DI PANEL PTERODACTYL? (y/n)"
            read -r HAS_DELETED_THEME

            if [[ "$HAS_DELETED_THEME" =~ ^[Yy]$ ]]; then
                echo -e "${YELLOW}𝗣𝗥𝗢𝗦𝗘𝗦 𝗜𝗡𝗦𝗧𝗔𝗟𝗟${NC}"
                echo -e "ᴊɪᴋᴀ ᴀᴅᴀ ᴘɪʟɪʜᴀɴ ᴅɪʙᴀᴡᴀʜ sɪʟᴀʜᴋᴀɴ ᴘɪʟɪʜ Y"

                sudo apt update && sudo apt install -y git
                cd /var/www/pterodactyl || { echo -e "${RED}Direktori tidak ditemukan!${NC}"; exit 1; }

                echo -e "${RED}PROSES PANEL ANDA AKAN DIMATIKAN SEMENTARA, UNTUK INSTALL TEMA${NC}"
                php artisan down || { echo -e "${RED}Gagal menonaktifkan panel!${NC}"; exit 1; }

                echo -e "${YELLOW}PANEL ANDA TELAH DIMATIKAN, MOHON TIDAK MENUTUP SESSION INI${NC}"
                if curl -L https://github.com/Nookure/NookTheme/releases/latest/download/panel.tar.gz | sudo tar -xzv -f -; then
                    animate_text "Tema berhasil diunduh dan diekstrak."
                else
                    echo -e "${RED}Gagal mengunduh atau mengekstrak tema!${NC}"; exit 1;
                fi

                sudo chmod -R 755 storage/* bootstrap/cache
                echo -e "${YELLOW}SILAHKAN KETIK 'yes' UNTUK MELANJUTKAN${NC}"
                sudo composer install --no-dev --optimize-autoloader || { echo -e "${RED}Gagal menjalankan composer!${NC}"; exit 1; }

                php artisan view:clear
                php artisan config:clear
                php artisan migrate --seed --force || { echo -e "${RED}Gagal migrasi database!${NC}"; exit 1; }

                sudo chown -R www-data:www-data /var/www/pterodactyl/*
                php artisan queue:restart
                echo -e "${GREEN}INSTALL THEME SELESAI${NC}"

                echo -e "${YELLOW}PROSES MENGAKTIFKAN KEMBALI PANEL PTERODACTYL ANDA${NC}"
                php artisan up || { echo -e "${RED}Gagal mengaktifkan kembali panel!${NC}"; exit 1; }

                echo -e "${GREEN}SELESAI, SILAHKAN MASUK KE WEB PANEL PTERODACTYL ANDA${NC}"
                exit 0
            else
                echo -e "${RED}Hapus semua tema terlebih dahulu sebelum melanjutkan!${NC}"
                exit 1
            fi
        else
            echo -e "${RED}Anda memerlukan panel Pterodactyl sebelum melanjutkan.${NC}"
            exit 1
        fi
        ;;
    22)
        # AUTO INSTALL PANEL + WINGS
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        echo -e "${GREEN}[+]          AUTO INSTALL PANEL + WINGS               [+]${NC}"
        echo -e "${GREEN}[+] =============================================== [+]${NC}"

        read -p "Masukkan Nama: " nama
        read -s -p "Masukkan Password: " pw
        echo
        read -p "Masukkan Subdomain: " subdo
        read -p "Masukkan NodeSubdomain: " nodesubdo
        read -p "Masukkan Email Admin: " admin_email

        if [[ -z "$nama" || -z "$pw" || -z "$subdo" || -z "$nodesubdo" || -z "$admin_email" ]]; then
            echo -e "${RED}Semua input wajib diisi. Silakan coba lagi.${NC}"
            exit 1
        fi

        # Menjalankan installer dengan input otomatis (Mode 2: Panel & Wings)
        bash <(curl -s https://pterodactyl-installer.se) <<EOF
2
\n
\n
$pw
Asia/Jakarta
$admin_email
$admin_email
$nama
$nama
$nama
$pw
$subdo
y
y
y
y
yes
A
y
y
y
$subdo
y
user
$pw
y
$nodesubdo
y
$admin_email
y
EOF

        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        echo -e "${GREEN}[+]              AUTO INSTALL SUKSES                  [+]${NC}"
        echo -e "${GREEN}[+] =============================================== [+]${NC}"
        exit 0
        ;;
    23)
        # Keluar
        echo -e "${BLUE}EXIT DARI INSTALLER DIPILIH${NC}"
        exit 0
        ;;
    *)
        echo -e "${RED}Pilihan tidak valid${NC}"
        ;;
esac

animate_text "${GREEN}𝗣𝗥𝗢𝗦𝗘𝗦 𝗦𝗘𝗟𝗘𝗦𝗔𝗜${NC}"