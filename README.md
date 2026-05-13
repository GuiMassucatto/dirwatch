![Banner](docs/banner-dirwatch.png)
# DirWatch
Sistema de Monitoramento de Diretórios em Bash

## 📘 Descrição  
O DirWatch é um sistema de monitoramento de diretórios desenvolvido em Bash, capaz de detectar alterações em arquivos em tempo real, registrando eventos automaticamente em logs e exibindo alertas coloridos no terminal. Ele detecta eventos como: 
- Criação de arquivos  
- Modificação de arquivos  
- Remoção de arquivos  

## 🎯 Objetivo do Projeto  
Este projeto foi desenvolvido como parte da disciplina de **Laboratório de Ferramentas de Programação**, com o objetivo de automatizar uma tarefa com Shell Script. Para isso, foi utilizado:  
- Shell Script  
- Estruturas de controle  
- Git/GitHub para versionamento  

## 🏆 Funcionalidades  
- Monitoramento contínuo de diretórios  
- Detecção de criação de arquivos  
- Detecção de remoção de arquivos  
- Detecção de modificação de arquivos  
- Registro de logs automáticos  
- Interface colorida no terminal

## 📚 Conceitos Utilizados

- Estruturas condicionais (`if`)
- Estruturas de repetição (`while` e `for`)
- Manipulação de arquivos e diretórios
- Automação de tarefas no Linux
- Monitoramento contínuo de diretórios
- Controle de versão com Git e GitHub
- Uso de logs para registro de eventos

## 📂 Estrutura de Pastas
```
dirwatch/
├── config/  -> Arquivo de configuração
│   └── config.conf
├── docs/  -> Documentação e identidade visual
│   └── banner-dirwatch.png
├── logs/  -> Logs gerados automaticamente
│   └── .gitkeep
├── monitored/  -> Diretório monitorado
│   └── exemplo.txt
├── src/  -> Script principal
│   └── dirwatch.sh
├── tests/  -> Scripts de testes
│   └── teste.sh
├── .gitignore
└── README.md
```

## 💻 Tecnologias Utilizadas  
- **Bash Shell Script** → Linguagem principal do sistema
- **Linux Ubuntu** → Ambiente de desenvolvimento e execução
- **Git** → Controle de versionamento
- **GitHub** → Hospedagem do repositório

## 🚀 Como Executar
1. Clone o repositório:
```
git clone https://github.com/GuiMassucatto/dirwatch.git
```
2. Entre na pasta do projeto:
```
cd dirwatch/
```
3. Dê permissão de execução ao script:
```
chmod +x src/dirwatch.sh
```
4. Execute o sistema:
```
./src/dirwatch.sh
```

## 📝 Exemplo de Saída
```
====================================
 DIRWATCH INICIADO
====================================
Monitorando: ./monitored
Intervalo: 2s
====================================
[CRIADO] hacker.txt em Tue May 12 18:50:04 -03 2026
[MODIFICADO] hacker.txt em Tue May 12 18:50:15 -03 2026
[REMOVIDO] hacker.txt em Tue May 12 18:50:21 -03 2026
```

## 🤖 Uso de IA
Conforme solicitado, este projeto contou com o auxílio de Inteligência Artificial para:

- Identidade Visual: Criação do conceito de design e banner do projeto.
- Estruturação de Documentação: Organização lógica deste arquivo README.
- Refatoração: Sugestões de melhorias na legibilidade do código Bash.
- Correção: Revisão de sintaxe e boas práticas de Shell Script.

## 👥 Integrantes
- Guilherme Stafocher Massucatto (RA: 322151)
- Kaik Medeiros Calarga (RA: 308782)
- Luiz Guilherme Barros Moragas (RA: 312382)
- Matheus Del Fiol Moretti (RA: 312393)
