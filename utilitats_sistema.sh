#!/bin/bash


# ==============================================================================
# Script: utilitats_sistema.sh
# Mòdul: M6_0374 Administració SO - RA7
# Descripció: Script modular per a la gestió del sistema mitjançant funcions.
# ==============================================================================


# ------------------------------------------------------------------------------
# Funció: benvinguda
# Descripció: Mostra un missatge personalitzat de benvinguda.
# Paràmetres:
#   $1 - Nom de l'alumne/usuari
# ------------------------------------------------------------------------------
benvinguda() {
    local nom_alumne="$1"
    echo "Hola ${nom_alumne}, anem a comprovar el sistema."
}


# ------------------------------------------------------------------------------
# Funció: comprova_usuari
# Descripció: Verifica si un usuari existeix al fitxer /etc/passwd.
# Paràmetres:
#   $1 - Nom de l'usuari a comprovar
# ------------------------------------------------------------------------------
comprova_usuari() {
    local usuari="$1"


    if grep -q "^${usuari}:" /etc/passwd; then
        echo "L'usuari '${usuari}' existeix al sistema."
    else
        echo "L'usuari '${usuari}' NO existeix al sistema."
    fi
}


# ------------------------------------------------------------------------------
# Funció: calculadora_espai
# Descripció: Mostra l'espai lliure de la partició principal (/).
# Paràmetres: Cap
# ------------------------------------------------------------------------------
calculadora_espai() {
    local espai_lliure
    
    echo "=== Espai lliure a la partició principal (/) ==="
    df -h /
}


# ==============================================================================
# LÒGICA PRINCIPAL DE L'SCRIPT
# ==============================================================================


# 1. Demanar el nom de l'alumne i cridar a la funció benvinguda
read -p "Introdueix el teu nom: " input_nom
benvinguda "$input_nom"
echo ""


# 2. Demanar un nom d'usuari i cridar a la funció comprova_usuari
read -p "Introdueix un nom d'usuari per verificar: " input_usuari
comprova_usuari "$input_usuari"
echo ""


# 3. Cridar a la funció calculadora_espai per tancar l'execució
calculadora_espai


exit 0
