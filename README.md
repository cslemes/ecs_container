## Template para criação de um cluster ECS na AWS

## Como usar

### Configurando a AWS

### Criando usuário IAM para o terraform

1. No console de gerenciamento da IAM, clique em *Users* e então clique no botão *Create User*.
![](images/Pasted%20image%2020241028135855.png)
2. Atribua o nome ao usuário, deixe desmarcado a opção "Provide access to AWS Console", o usuário exclusivo do Terraform não precisa acessar a console, clique em Next.
![](images/Pasted%20image%2020241028140142.png)

3. Em Set permissions marque a opção *Attach policies directly*, marque *AdministratorAccess* e clique em *Next*, revise na proxima tela e clique em *Create user*.
![](images/Pasted%20image%2020241029100131.png)
O uso de `AdministratorAccess` é apenas para testes ou ambientes de desenvolvimento. Para produção, adotar uma política com permissões mínimas (least privilege) seria mais seguro.

4. Clique no nome de usuário na guia do IAM Users.
![](images/Pasted%20image%2020241029101428.png)
5. Em *Access key 1* cliquem em Create access key.
![](images/Pasted%20image%2020241029101524.png)
6. Em Acces key best practices & alternatives escolha *other* e clique em Next
7. Pode deixar a Tag em branco e clique em *Create acces key*. Salve as credencias para usarmos posteriormente, você não conseguirá pegar a secret novamente.
### Criando um Bucket para armazenar o State do Terraform
1. Acesse o console do S3 e clique no botão *Create bucket*
![](images/Pasted%20image%2020241029203935.png)
2. Coloque um nome no bucket, o nome dos bucket são unicos em todas as contas AWS, deixei as demais opções padrão, e clique em *Create bucket*.
![](images/Pasted%20image%2020241029204214.png)
### Instalando o Cli do Terraform

Terraform:
```bash
curl -fsSl  "https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip" -o terraform.zip
unzip terraform.zip
sudo mv terraform /usr/local/bin/
```

### Aqui está uma breve explicação de cada arquivo HCL:

1. **ecs.tf**: Define o cluster ECS, onde os contêineres serão executados.
2. **iam.tf**: Configura as permissões IAM necessárias para recursos e usuários.
3. **internet_gateway.tf**: Cria um Internet Gateway para permitir acesso externo à rede.
4. **nat_gateway.tf**: Cria um NAT Gateway para permitir que sub-redes privadas acessem a internet de forma controlada.
5. **outputs.tf**: Define as saídas que o Terraform exibirá após a criação dos recursos (como IDs ou URLs).
6. **parameters.tf**: Armazena parâmetros específicos, como configurações que podem ser reutilizadas em vários arquivos.
7. **private_subnets.tf**: Cria sub-redes privadas, isoladas da internet para maior segurança.
8. **providers.tf**: Configura os provedores necessários para o Terraform, como AWS.
9. **public_subnets.tf**: Cria sub-redes públicas, permitindo o acesso direto à internet.
10. **service_discovery.tf**: Configura o Service Discovery para permitir a descoberta de serviços no cluster ECS.
11. **sg.tf**: Define os Security Groups (SGs), que controlam o tráfego de entrada e saída para os recursos.
12. **terraform.tfvars**: Arquivo de variáveis, usado para definir valores que serão passados para o Terraform, como configurações específicas do ambiente.
13. **variables.tf**: Declara variáveis usadas nos outros arquivos, facilitando a configuração dinâmica e reutilizável.
