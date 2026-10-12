#!/bin/bash
# menu.sh - Menu d'administracio del sistema
# Activitat A03 - Administracio SO
# Us: ./menu.sh                  (menu interactiu)
#     ./menu.sh 1                (info del sistema)
#     ./menu.sh 3 usuari         (comprovar si existeix un usuari)
#     ./menu.sh -b /ruta         (copia de seguretat d'una carpeta)

# Funcio que mostra el menu
# No rep parametres
mostrar_menu() {
    echo ""
    echo "===== ADMINISTRACIO DEL SISTEMA ====="
    echo "1) Informacio del sistema"
    echo "2) Espai en disc"
    echo "3) Comprovar un usuari"
    echo "4) Processos que mes consumeixen"
    echo "5) Copia de seguretat d'una carpeta"
    echo "0) Sortir"
    echo "====================================="
}

# Funcio que mostra informacio basica del sistema
# No rep parametres
info_sistema() {
    local maquina=$(hostname)
    local nucli=$(uname -r)
    local temps=$(uptime -p)
    echo "Maquina: $maquina"
    echo "Nucli: $nucli"
    echo "Temps encesa: $temps"
    free -h | grep Mem
}

# Funcio que mostra l'espai en disc
# No rep parametres
espai_disc() {
    df -h | grep -v tmpfs
}

# Funcio que comprova si un usuari existeix al sistema
# Rep un parametre: $1 (nom de l'usuari)
comprovar_usuari() {
    local usuari=$1
    if [ -z "$usuari" ]; then
        read -p "Nom de l'usuari: " usuari
    fi
    if id "$usuari" &> /dev/null; then
        echo "L'usuari $usuari existeix:"
        id "$usuari"
    else
        echo "L'usuari $usuari NO existeix"
    fi
}

# Funcio que mostra els 5 processos que mes CPU fan servir
# No rep parametres
top_processos() {
    ps aux --sort=-%cpu | head -6
}

# Funcio que fa una copia de seguretat comprimida d'una carpeta
# Rep un parametre: $1 (carpeta a copiar)
fer_backup() {
    local carpeta=$1
    if [ -z "$carpeta" ]; then
        read -p "Carpeta a copiar: " carpeta
    fi
    if [ ! -d "$carpeta" ]; then
        echo "Error: $carpeta no es una carpeta valida"
        return 1
    fi
    local nom="backup_$(basename "$carpeta")_$(date +%Y%m%d_%H%M).tar.gz"
    tar -czf "$nom" "$carpeta" 2> /dev/null
    echo "Copia creada: $nom"
}

# ---------- Programa principal ----------

# Si hi ha parametres, executem l'opcio directament
if [ $# -gt 0 ]; then
    case $1 in
        1|-i|--info)    info_sistema ;;
        2|-d|--disk)    espai_disc ;;
        3|-u|--user)    comprovar_usuari "$2" ;;
        4|-p|--procs)   top_processos ;;
        5|-b|--backup)  fer_backup "$2" ;;
        *) echo "Opcio no valida. Prova: 1-5, -i, -d, -u, -p, -b" ;;
    esac
    exit 0
fi

# Sense parametres: menu en bucle fins que s'escull sortir
opcio=""
while [ "$opcio" != "0" ]; do
    mostrar_menu
    read -p "Tria una opcio: " opcio
    case $opcio in
        1) info_sistema ;;
        2) espai_disc ;;
        3) comprovar_usuari ;;
        4) top_processos ;;
        5) fer_backup ;;
        0) echo "Adeu!" ;;
        *) echo "Opcio no valida" ;;
    esac
done
