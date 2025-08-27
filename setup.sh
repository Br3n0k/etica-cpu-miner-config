# Verifica se existe o python instalado
if ! command -v python3 &> /dev/null
then
    # Instala o python 3
    apt install python3 -y

    # Instala as dependências
    apt install python3-pip -y
fi

# Define o diretorio da aplicação
APP_DIR="/etc/n0k/etica"

# Cria o diretorio da aplicação
mkdir -p $APP_DIR

# Download python script from repository with retries
script_files=(
    "https://raw.githubusercontent.com/Br3n0k/etica-cpu-miner-config/refs/heads/main/script/main.py"
    "https://raw.githubusercontent.com/Br3n0k/etica-cpu-miner-config/refs/heads/main/script/requirements.txt"
)

max_attempts=3

for script_url in "${script_files[@]}"; do
    attempt=1
    download_success=false
    filename=$(basename "$script_url")
    
    while [ $attempt -le $max_attempts ] && [ "$download_success" = false ]; do
        if curl -s --fail "$script_url" > "$APP_DIR/$filename"; then
            download_success=true
            echo "Successfully downloaded $filename on attempt $attempt"
        else
            echo "Attempt $attempt of $max_attempts failed to download $filename"
            if [ $attempt -lt $max_attempts ]; then
                echo "Retrying in 5 seconds..."
                sleep 5
            fi
            attempt=$((attempt + 1))
        fi
    done

    if [ "$download_success" = false ]; then
        echo "Failed to download $filename after $max_attempts attempts"
        exit 1
    fi
done