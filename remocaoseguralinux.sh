#!/bin/bash

echo "⚠️  Você está tentando executar: rm $*"
echo "‼️  Esta operação é potencialmente destrutiva e irreversível."

read -p "Tem certeza que quer continuar? (s/N): " primeira
primeira=${primeira,,}  # converte para minúscula

if [[ "$primeira" != "s" ]]; then
    echo "❌ Cancelado."
    exit 1
fi

read -p "Digite 1 para remover ou 0 para cancelar: " segunda

if [[ "$segunda" == "1" ]]; then
    echo "🧨 Executando rm $*"
    /bin/rm "$@"
else
    echo "❌ Cancelado."
    exit 1
fi
