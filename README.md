# Estrutura básica de Iac para AWS

Contém 2 máquinas básicas **t2.nano** com Amazon Linux e um Apache na maquina 1

_**ts.nano** está como default, pode ser alterado no arquivo variables.tf_.

- ec2-public: maquina com acesso público a internet (com apache instalado)
- ec2-private: maquina sem acesso público a internet (para um DB ou serviços "internos" por exemplo)

## Pré-requisitos
- AWS CLI instalado e configurado
- Terraform instalado
- chave IAM criada para ser utilizada no acesso às instancias via SSH (coloque a chave no mesmo diretório e inclua-a no .gitignore)
- configurar nome da chave no arquivo variables.tf como 'default' (cuidado para nao subir este arquivo para o git)
ou criar arquivo terraform.tfvars (com mesmo intuito do variables.tf) e adicionar a chave lá (recomendado) coloque este arquivo no .gitignore


## Como usar
```bash
terraform init
terraform plan
terraform apply
```

## Como destruir
Faça a destruição das instancias para não gerar custos desnecessários, caso naõ vá mais utilizar o projeto.

```bash
terraform destroy
```




## Observações
enviar a chave via *SCP* para a maquina publica para acessar a maquina privada de dentro dela (modo não-seguro, mas útil para testes rápidos)

exemplo: 
```bash
scp -i "chave.pem" chave.pem ec2-user@ip-da-maquina-publica:/home/ec2-user
```
