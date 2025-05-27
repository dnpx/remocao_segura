🛡️ Proteção Avançada Contra Exclusão Acidental com rm -rf
📌 Objetivo
Evitar exclusões irreversíveis causadas por comandos perigosos como:

bash
Copiar
Editar
rm -rf *.*
rm -rf /
rm -rf /var/www/site
Ao configurar esta proteção, o comando rm será interceptado por um wrapper interativo, que:

Exibe alertas visuais de risco;

Solicita confirmação textual e confirmação numérica;

Só executa a remoção após dupla confirmação;

Protege você contra erros por distração ou digitação incorreta.

🛠️ Instalação Passo a Passo
1. Crie o script seguro chamado rm-safe
Abra o terminal e execute:

bash
Copiar
Editar
sudo nano /usr/local/bin/rm-safe
Cole o conteúdo abaixo:

bash
Copiar
Editar
#!/bin/bash

echo -e "\n⚠️  Você está tentando executar: \033[1;33mrm $*\033[0m"
echo "‼️  Esta operação é potencialmente destrutiva e irreversível."
echo ""

read -p "Tem certeza que quer continuar? (s/N): " primeira
primeira=${primeira,,}  # converte para minúscula

if [[ "$primeira" != "s" ]]; then
    echo "❌ Operação cancelada na primeira confirmação."
    exit 1
fi

read -p "Digite 1 para REMOVER ou 0 para CANCELAR: " segunda

if [[ "$segunda" == "1" ]]; then
    echo "🧨 Executando: rm $*"
    /bin/rm "$@"
else
    echo "❌ Operação cancelada na segunda confirmação."
    exit 1
fi
Esse script atua como substituto seguro do comando rm.

2. Torne o script executável
bash
Copiar
Editar
sudo chmod +x /usr/local/bin/rm-safe
3. Crie um alias para substituir rm por rm-safe
Abra o arquivo de configuração do shell:

bash
Copiar
Editar
nano ~/.bashrc
No final do arquivo, adicione:

bash
Copiar
Editar
alias rm='rm-safe'
Depois aplique com:

bash
Copiar
Editar
source ~/.bashrc
Em servidores que usam zsh, edite ~/.zshrc em vez de ~/.bashrc.

🧪 Como usar
Exemplo 1: Tentando deletar arquivos
bash
Copiar
Editar
rm -rf /var/www/teste
Resultado esperado:
bash
Copiar
Editar
⚠️  Você está tentando executar: rm -rf /var/www/teste
‼️  Esta operação é potencialmente destrutiva e irreversível.

Tem certeza que quer continuar? (s/N): s
Digite 1 para REMOVER ou 0 para CANCELAR: 0
❌ Operação cancelada na segunda confirmação.
Nada será removido se você digitar qualquer coisa diferente de s e 1.

✅ Reversibilidade (como desativar temporariamente)
Se você quiser usar o rm padrão em um caso específico, execute:

bash
Copiar
Editar
\rm -rf pasta
# ou
/bin/rm -rf pasta
Se quiser desativar o alias completamente:

bash
Copiar
Editar
unalias rm
🔐 Proteção Extra: Tornar diretórios imutáveis com chattr
Além do wrapper do rm, você pode usar o comando chattr para tornar diretórios protegidos mesmo contra rm -rf como root:

Tornar imutável:
bash
Copiar
Editar
chattr -R +i /var/www/meusite.com.br
Tornar mutável novamente:
bash
Copiar
Editar
chattr -R -i /var/www/meusite.com.br
⚠️ chattr só funciona em sistemas de arquivos compatíveis (como ext4).

♻️ Automatização para múltiplos servidores
Se desejar aplicar esse sistema a vários servidores:

Salve o script rm-safe como .deb, ou

Use um pequeno script de instalação remota via scp + ssh, que posso gerar para você.

📝 Conclusão
Com esse sistema:

Você evita desastres causados por rm -rf mal digitado;

Mantém controle com dupla confirmação antes de qualquer exclusão;

Pode ainda usar chattr para blindar pastas críticas permanentemente.

