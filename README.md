# Documentação Atividade Prática

# Requisitos:
### Instancia AWS:

•	Chave pública para acesso ao ambiente

•	Amazon Linux 2 

- t3.small

-	16 GB SSD

### •	1 Elastic IP associado a instancia

•	Portas de comunicação liberadas 

-	22/TCP (SSH)
-	111/TCP e UDP (RPC)
- 2049/TCP/UDP (NFS)
- 80/TCP (HTTP)
- 443/TCP (HTTPS)
  
## Configurações Linux:

•	Configurar o NFS entregue;

•	Criar um diretorio dentro do filesystem do NFS com seu nome;

•	Subir um apache no servidor - o apache deve estar online e rodando;

•	Criar um script que valide se o serviço esta online e envie o resultado da validação para o seu diretorio no nfs; 

-	O script deve conter - Data HORA + nome do serviço + Status + mensagem personalizada de ONLINE ou offline;
-	O script deve gerar 2 arquivos de saida: 1 para o serviço online e 1 para o serviço OFFLINE;
-	Execução automatizada do script a cada 5 minutos.
  
# Instruções de Execução:

## Parte AWS
### Gerar chave pública:

•	Faça login no Console de Gerenciamento da AWS.

•	Navegue até o Dashboard do EC2.

•	Vá em Rede e Segurança e clique em Par de Chaves

•	Clique em Criar par de chaves.

•	Dê um nome ao par de chaves e escolha o formato ".pem".

•	Baixe o arquivo do par de chaves .

### Criar uma Instância EC2:

•	Criar um VPC.

•	Criar um Subnet.

•	Criar um Internet Gateway e anexá-lo ao VPC.

•	Criar uma Tabela de Rotas e adicionar uma rota para o Internet Gateway.

•	Associar a Tabela de Rotas ao Subnet.

•	No Dashboard do EC2, clique em (Iniciar Instância).

•	Escolha o "Amazon Linux 2 AMI (HVM), SSD Volume Type".

•	Selecione o tipo de instância t3.small.

•	Configure os detalhes da instância, incluindo configurações de rede e subnet.

•	Adicione o armazenamento com 16 GB SSD.

•	Adicione tags conforme necessário.

### Configure o grupo de segurança:

•	Adicione regras para as seguintes portas:

22 (SSH), 

111 (TCP/UDP), 

2049 (TCP/UDP), 

80 (HTTP), 

443 (HTTPS).

### Alocar e Associar um Elastic IP:
•	Vá para a seção "Elastic IPs" sob "Network & Security".

•	Clique em "Allocate Elastic IP address" (Alocar endereço IP elástico) e aloque.

•	Selecione o IP elástico alocado, clique em Ações e escolha Associar endereço IP elástico.

•	Selecione sua instância EC2 e associe o IP elástico.

# Parte Linux:
### Configurar o NFS com o IP fornecido
 
•	Instalar o pacote ```nfs-utils: sudo yum install nfs-utils.```

•	Criar diretório: ```sudo mkdir -p /nfs/paulo```

•	Conceder permissões: ```sudo chmod 777 /nfs/paulo```

•	Configurar o NFS para compartilhamento: ```sudo nano /etc/exportfs -r```

•	Adicionar a seguinte linha no arquivo /etc/fstab: ```*(rw, sync)```

•	Exportar o diretório nfs: ```sudo exportfs -r```

### Configurar o Apache.

•	Executar o comando ```sudo yum install httpd -y``` para instalar o apache.

•	Executar o comando ```sudo systemctl start httpd``` para iniciar o apache.

•	Executar o comando ```sudo systemctl enable httpd``` para habilitar o apache para iniciar automaticamente.

•	Executar o comando ```sudo systemctl status httpd``` para verificar o status do apache.

### Configurar o script de validação.

•	Crie um novo arquivo de script usando o comando "nano script.sh".

•	Adicione as seguintes linhas de código no arquivo de script:
```bash
#!/bin/bash

DATA=$(date +%d/%m/%Y)

HORA=$(date +%H:%M:%S)

SERVICO="httpd"

STATUS=$(systemctl is-active $SERVICO)

if [ $STATUS == "active" ]; then

    MENSAGEM="O $SERVICO está ONLINE"echo "$DATA $HORA - $SERVICO - active - $MENSAGEM" >> /nfs/paulo/online.txt

else

    MENSAGEM="O $SERVICO está offline"echo "$DATA $HORA - $SERVICO - inactive - $MENSAGEM" >> /nfs/paulo/offline.txt

Fi 
```
•	Salve o arquivo de script.

•	Execute o comando ```chmod +x script.sh``` para tornar o arquivo de script executável.

•	Execute o comando ```cat ./script.sh``` para executar o script.

### Configurar a execução do script de validação a cada 5 minutos.

Execute o comando crontab -e para editar o cronjob.

Adicione a seguinte linha de código no arquivo de cronjob:

*/5 * * * * /home/ec2-user/script.sh

Salve o arquivo de cronjob.

Execute o comando crontab -l para verificar se o cronjob foi configurado corretamente.
