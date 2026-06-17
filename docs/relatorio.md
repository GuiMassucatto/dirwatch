# Relatório Técnico — Projeto DirWatch

## 1. Introdução

O crescimento do uso de sistemas Linux em ambientes acadêmicos, corporativos e servidores torna cada vez mais relevante a automatização de tarefas rotineiras. Entre essas tarefas, o monitoramento de arquivos e diretórios é fundamental para garantir organização, controle e segurança de informações.

Neste contexto, foi desenvolvido o **DirWatch**, um sistema de monitoramento contínuo de diretórios utilizando **Shell Script (Bash)**, capaz de detectar automaticamente alterações em arquivos, registrando eventos em logs e exibindo notificações coloridas no terminal.

O projeto foi desenvolvido como atividade prática da disciplina de **Laboratório de Ferramentas de Programação**, utilizando conceitos fundamentais de automação em Linux e controle de versão com Git e GitHub.

---

## 2. Objetivo do Projeto

O principal objetivo do projeto foi desenvolver uma ferramenta capaz de automatizar o monitoramento de diretórios em ambiente Linux, utilizando Shell Script.

Além da automação, o sistema foi concebido com foco em controle e segurança, permitindo identificar rapidamente alterações realizadas em arquivos e diretórios monitorados. Dessa forma, o DirWatch contribui para a manutenção da integridade do ambiente monitorado, registrando eventos de criação, modificação e remoção de arquivos por meio de logs e notificações em tempo real.

Além disso, o projeto buscou aplicar na prática conceitos estudados durante a disciplina, como:

- Estruturas condicionais
- Estruturas de repetição
- Manipulação de arquivos e diretórios
- Automação de tarefas
- Registro de logs
- Controle de versão com Git e GitHub

---

## 3. Tecnologias Utilizadas

Durante o desenvolvimento do sistema, foram utilizadas as seguintes tecnologias:

| Tecnologia | Finalidade |
|---|---|
| Bash Shell Script | Desenvolvimento do sistema |
| Linux Ubuntu | Ambiente de execução |
| Git | Controle de versionamento |
| GitHub | Hospedagem do repositório |
| Markdown | Documentação do projeto |

---

## 4. Estrutura do Projeto

O projeto foi organizado em diretórios específicos para facilitar manutenção, organização e escalabilidade.

```text
dirwatch/
├── config/
│   └── config.conf
├── docs/
│   └── banner-dirwatch.png
│   └── icon-dirwatch.png
│   └── relatorio.md
├── logs/
│   └── .gitkeep
├── monitored/
│   └── .gitkeep
├── src/
│   └── dirwatch.sh
├── tests/
│   └── teste.sh
├── .gitignore
└── README.md
```

### Descrição das Pastas
| Pasta | Função |
|----------|----------|
| config/ | Arquivos de configuração do sistema |
| docs/ | Documentação e identidade visual |
| logs/ | Armazenamento dos logs gerados |
| monitored/ | Diretório monitorado pelo sistema |
| src/ | Código-fonte principal |
| tests/ | Script de teste automatizado |

---

## 5. Funcionamento do Sistema
O sistema realiza monitoramento contínuo de um diretório específico configurado no arquivo ```config.conf```.
A execução ocorre em ciclos contínuos utilizando um loop ```while```, onde o sistema:
1. Lê os arquivos existentes no diretório monitorado
2. Armazena o estado atual dos arquivos
3. Compara o estado atual com o estado anterior
4. Detecta:
     - Criação de arquivos
     - Modificação de arquivos
     - Remoção de arquivos
5. Registra os eventos no terminal e no arquivo de log
6. Exibe estatísticas de eventos detectados ao encerrar a execução
7. Permite encerramento controlado via `CTRL+C`

### Inicialização e Encerramento

Ao iniciar a execução, o sistema exibe informações como:
- Diretório monitorado
- Intervalo de verificação
- Horário de início da execução

Além disso, o sistema possui encerramento controlado utilizando o recurso `trap` do Bash, permitindo capturar o evento de interrupção via `CTRL+C`.

Ao ser encerrado, o DirWatch exibe:
- Horário de encerramento
- Quantidade de arquivos criados
- Quantidade de arquivos modificados
- Quantidade de arquivos removidos
- Localização do arquivo de log

---

## 6. Detecção de Eventos
### 6.1 Criação de Arquivos
O sistema verifica se determinado arquivo não existia anteriormente e passou a existir no estado atual do diretório.

Exemplo:
```text
[CRIADO] exemplo.txt
```

### 6.2 Modificação de Arquivos
A detecção de modificação é realizada através da comparação do tamanho dos arquivos entre diferentes ciclos de monitoramento.
Quando o tamanho do arquivo é alterado, o sistema registra um evento de modificação.

Exemplo:
```text
[MODIFICADO] exemplo.txt
```

### 6.3 Remoção de Arquivos
O sistema também verifica arquivos presentes anteriormente que deixaram de existir no diretório monitorado.

Exemplo:
```text
[REMOVIDO] exemplo.txt
```

---

## 7. Interface do Sistema
Para melhorar a visualização durante a execução, o sistema utiliza códigos ANSI para exibir mensagens coloridas no terminal:

| Evento      | Cor      |
| ----------- | -------- |
| Criação     | Verde    |
| Modificação | Amarelo  |
| Remoção     | Vermelho |

Essa funcionalidade melhora a experiência de uso e facilita a identificação rápida dos eventos detectados.

Além das cores ANSI, o sistema também apresenta:
- Horário de início da execução
- Horário de encerramento
- Estatísticas finais de monitoramento
- Mensagens organizadas visualmente no terminal

Esses elementos tornam a utilização mais intuitiva e melhoram a experiência do usuário durante o monitoramento.

---

## 8. Registro de Logs
Todos os eventos detectados são registrados automaticamente no arquivo:
```text
logs/monitor.log
```

Os logs permitem auditoria e rastreabilidade das alterações detectadas, permitindo manter o histórico das alterações detectadas pelo sistema.

Exemplo de log:
```bash
[CRIADO] teste.txt em Tue May 12 18:50:04 -03 2026
[MODIFICADO] teste.txt em Tue May 12 18:50:15 -03 2026
[REMOVIDO] teste.txt em Tue May 12 18:50:21 -03 2026
```

---

## 9. Testes Automatizados

O projeto possui um script automatizado de testes localizado em:

```text
tests/teste.sh
```

Esse script foi desenvolvido com o objetivo de validar rapidamente o funcionamento do sistema.

Durante a execução, o script realiza automaticamente:

- Criação de arquivos
- Modificação de arquivos
- Remoção de arquivos

Essas ações permitem verificar se o sistema de monitoramento está detectando corretamente todos os eventos esperados.

---

## 10. Conceitos de Programação Utilizados
Durante o desenvolvimento do projeto, foram aplicados diversos conceitos estudados na disciplina.

Dentre eles:

### Estruturas Condicionais
Utilização de:
```text
if
then
else
```
Para tomada de decisões no sistema.

### Estruturas de Repetição
Utilização de:
```text
while
for
```
Para monitoramento contínuo e varredura de arquivos.

### Manipulação de Arquivos
Foram utilizados comandos Linux para:
- Leitura de arquivos
- Verificação de diretórios
- Captura de tamanho de arquivos
- Escrita em logs

### Automação em Linux
O projeto automatiza completamente o processo de monitoramento de diretórios em ambiente Linux.

---

## 11. Controle de Versão com Git e GitHub
O desenvolvimento do projeto utilizou Git e GitHub para controle de versão e organização do trabalho em equipe.
Foram utilizados recursos como:
- Commits frequentes
- Branches para desenvolvimento de funcionalidades
- Merges
- Versionamento do código-fonte

Essa abordagem permitiu maior organização e rastreabilidade durante o desenvolvimento.

---

## 12. Uso de Inteligência Artificial
O projeto contou com apoio de Inteligência Artificial Generativa em etapas específicas do desenvolvimento.

A utilização da IA teve caráter exclusivamente consultivo e educacional, sendo empregada como ferramenta de apoio durante o desenvolvimento do sistema. Entre as principais contribuições, destacam-se:

- Auxílio na identificação e correção de erros de sintaxe em Shell Script;
- Sugestões de refatoração para melhorar a legibilidade e organização do código;
- Explicação de comandos, estruturas e recursos da linguagem Bash utilizados no projeto;
- Apoio na implementação de funcionalidades complementares, como utilização de códigos ANSI para exibição de mensagens coloridas no terminal;
- Auxílio na compreensão e utilização do comando trap, empregado para realizar o encerramento controlado do sistema e exibição das estatísticas finais de execução;
- Sugestões para implementação do contador de eventos monitorados;
- Apoio na criação do script automatizado de testes para validação das funcionalidades do sistema;
- Sugestões relacionadas à organização da estrutura de diretórios do projeto;
- Apoio na elaboração da documentação técnica, incluindo o README e este relatório;
- Auxílio na criação da identidade visual do projeto, incluindo o conceito do banner utilizado na documentação;
- Orientações sobre boas práticas de versionamento utilizando Git e GitHub, incluindo uso de branches, commits e merges.

É importante ressaltar que toda a implementação do código-fonte, realização dos testes, validação dos resultados, tomada de decisões técnicas e compreensão dos conceitos utilizados foram realizadas pelos integrantes do grupo. A Inteligência Artificial foi utilizada apenas como ferramenta de apoio ao aprendizado e ao desenvolvimento do projeto.

---

## 13. Conclusão
O desenvolvimento do DirWatch permitiu aplicar de forma prática diversos conceitos fundamentais relacionados à automação em Linux utilizando Shell Script.
Além disso, o projeto contribuiu para o aprendizado de:
- Monitoramento de arquivos
- Manipulação de diretórios
- Automação de tarefas
- Organização de projetos
- Uso de Git e GitHub
- Documentação técnica

O sistema desenvolvido atende aos objetivos propostos pela disciplina, apresentando funcionamento correto, organização adequada e aplicação prática dos conceitos estudados.

Além das funcionalidades básicas de monitoramento, o projeto evoluiu para incorporar melhorias relacionadas à experiência do usuário, como interface colorida, estatísticas de eventos e testes automatizados, tornando o sistema mais completo e robusto.
