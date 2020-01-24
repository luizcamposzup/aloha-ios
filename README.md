# Aloha
Project: 288 Projeto J.R.S

Projeto de totem para recepção - versão IOS

## Versão

1.0

## Requerimentos

+ Xcode 11.2 (ou maior)
+ OS 13.2 (ou maior)
+ iPad
+ iCloud - perfil de provisionamento habilitado


## Configuração

A configuração do projeto Xcode requer algumas etapas no Xcode para começar a funcionar com os recursos do iCloud.

1) Configure todos os dispositivos iOS que planeja testar com uma conta do iCloud. Crie ou use uma conta Apple ID existente que suporte o iCloud.

2) Configure a equipe para cada destino dentro do projeto.

Abra o projeto no navegador do projeto no Xcode e selecione cada um dos destinos. Defina a equipe na guia Geral para a equipe associada à sua conta de desenvolvedor.

3) Altere o identificador do pacote.

Com a guia Geral do projeto ainda aberta, atualize o valor do Identificador de pacote:

br.com.zup.aloha


## Arquitetura do projeto

### Desenvolvimento em geral

+ Linguagem Swift
+ Arquitetura Model View Controller (MVC)
+ Uso de Storyboard para confecção do design das telas
+ Toda a aplicação é desenvolvida em inglês, com resalva apenas para mensagens mostradas para o usuário.
+ Toda tela deve ter sua respectiva classe ViewController 
+ Toda classe ViewController deve estender a classe BaseViewController
+ A BaseViewController contém métodos comuns a todas ViewControllers
+ Toda chamada de serviço (API) deverá ser feita por seu respectivo método Request, implementando os métodos de retorno da resposta
+ Uso de uma struct para armazenamento das informações durante o fluxo do usuário
+ Não é utilizada dependência alguma no podFile


### Gerenciamento de versionamento

+ Utilizar o gerenciamento de versionamento GitFlow
+ Ao homologar uma release, todas as branches devem ser deletadas, exceto as branches master e a branch da respectiva release
+ Para criar branchs, padronizou-se o uso de "-" (hífen) para separar as palavras ou contextos.
+ Todos os merges deverão ser feitos via PullRequest na branch originária (ou criada a partir)  com review e aprovação de outro membro do time.
+ Devem ser criadas branches para cada features da aplicação, as quais devem ser mergeadas com a banch develop
+ Ao finalizar a aplicação desenvolvida para testes, gerar uma branch release
+ Sempre que criar a branch release todos os bugfix referentes a tasks já mergeadas nessa branch ou que necessitem de ser corrigidos na mesma versão deverão ser criadas a partir da respectiva branch release e não da develop.
+ Nas atividades normais de uma sprint, antes da criação da branch de release/v-Version o bugfix deverá ser criado a partir da develop.
+ Em caso de correções de produção deverá ser criada a partir da master a branch hotfixes/v-bundleName (Ex. hotfixes/v-1.1.3)
+ Sempre que atualizar uma versão de hotfixes durante a Sprint, a mesma deverá ser mergeada na develop.
+ Ao finalizar uma Sprint fazer o merge da branch release na master e posteriormente na develop.
+ Sempre gerar a Tag referente a versão disponibilizada em produção. Ex. v-1.1.3


#### Nomenclatura de branches

| Nomenclatura                               | Exemplo                          | Criada a partir   | Observação                                                                                             |
| :-------------------------------------:|:----------------------------:|:------------------:|:-------------------------------------------------------------------------------:|
| develop                                         | develop                           | master               | Agrupa todas as branches referentes a desenvolvimento de features  |
| feature/taskNumber-description   | feature/123-descrição    | develop             | Atividades da sprint ativa no fluxo de desenvolvimento                        |
| hotfixes/v-bundleName                |hotfixes/v-1.1.3                | master               | Agrupa todas as branches referente a erros de produção                    |
| hotfix/taskNumber-description     |hotfix/123-descrição       | master               | Correções de erros de produção                                                           |
                                                    
                                                    
#### Nomenclatura de tags
 
 | Nomenclatura                    | Exemplo                 | Criada a partir                        | Observação  |
 | :-----------------------------:|:----------------------:|:--------------------------------:|:---------------:|
 | v-bundleName                   |v-1.1.3                     | master                                   |      -                |
  
                                                                          
#### Referências                                  

1. bundleName e bundleVersion:

São variáveis que definem o nome ou número da versão (1.1.3, teste1, etc..) e o código de controle de versão utilizada pela Apple Store respectivamente. Elas se encontram no arquivo Info.plist build.gradle do projeto Android

   ```
   ...
   <key>CFBundleName</key>
   <string>$(PRODUCT_NAME)</string>
   <key>CFBundlePackageType</key>
   <string>$(PRODUCT_BUNDLE_PACKAGE_TYPE)</string>
   <key>CFBundleShortVersionString</key>
   <string>1.0</string>
   <key>CFBundleVersion</key>
   <string>1</string>
   ...
   
```
   O bundleName e o bundleVersion devem ser alterados (incrementação no caso do bundleVersion) sempre que se criar uma branch hotfixes ou release.
   
2. taskNumber:

   São as referências das atividades criadas na plataforma utilizada para gestão do projeto. Ex: ABC-9976 (JIRA).
 
3.  service:

  Trata-se de uma descrição abreviada e clara da atividade referenciada pela branch. Ex. service-login


### Nomeclatura para componentes UIView (TextField, UIImage, Button...)

  O nome deve seguir o padrão (NomeDoQueEleRepresenta)TextField, (NomeDoQueEleRepresenta)UIImage, (NomeDoQueEleRepresenta)Button...
Ex: nameTextField (Representa a textfield de input de uma informação de nome).

### Nomeclatura para arquivos ViewController, Model, Data, etc...

  O nome deve seguir o padrão (NomeDoQueEleRepresenta)ViewController, (NomeDoQueEleRepresenta)Model, (NomeDoQueEleRepresenta)Data...
Ex: WelcomeViewController (Representa tela inicial do sistema).


### Links úteis

1. GitFlow
    
    http://nvie.com/posts/a-successful-git-branching-model/

2. Documentação Swift
    
    https://developer.apple.com/documentation/swift
    
3. MVC
   
   https://medium.com/ios-os-x-development/modern-mvc-39042a9097ca
   
   
## License

©Copyright 2020 Zup. Todos os direitos reservados.

    
