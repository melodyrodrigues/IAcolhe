# IAcolhe

Sistema de apoio financeiro para reconstrução de moradias afetadas por calamidades climáticas.

## 📋 Sobre o Projeto

O **IAcolhe** é uma plataforma digital que facilita o acesso ao programa de **Auxílio Reconstrução**, oferecendo suporte tecnológico para cidadãos e gestores públicos no processo de solicitação e análise de benefícios para reparos e recuperação de moradias danificadas por eventos climáticos.

### Principais Funcionalidades

#### Para Cidadãos

- **Assistente Virtual Inteligente**: Chatbot com IA que orienta o solicitante através do processo de elegibilidade

- **Triagem Automatizada**: Validação inicial de elegibilidade baseada em critérios objetivos

- **Upload de Documentos**: Sistema seguro para envio de comprovantes e evidências (fotos, documentos de identificação, comprovantes de residência)

- **Processamento OCR**: Extração automática de dados de documentos enviados

- **Acompanhamento em Tempo Real**: Visualização do status do processo

#### Para Gestores Públicos

- **Dashboard Governo**: Painel administrativo para análise e gestão de solicitações

- **Análise Documental com IA**: Ferramentas de processamento inteligente de documentos

- **Relatórios e Analytics**: Visão consolidada de solicitações e indicadores

## 🎯 Objetivo

Simplificar e acelerar o acesso ao auxílio reconstrução, garantindo:

- **Acessibilidade**: Interface intuitiva e assistência automatizada

- **Transparência**: Critérios claros de elegibilidade

- **Eficiência**: Redução do tempo de análise através de automação

- **Empatia**: Atendimento humanizado e acolhedor em momento de vulnerabilidade

## 🚀 Tecnologias

Este projeto utiliza tecnologias modernas para garantir performance, segurança e escalabilidade:

- **Frontend**: React 18 + TypeScript + Vite

- **Estilização**: Tailwind CSS + shadcn/ui

- **Backend**: Lovable Cloud (Supabase)

- **Inteligência Artificial**: Modelos Gemini 2.5 (via Lovable AI Gateway)

- **Processamento de Documentos**: OCR via Edge Functions

- **Gerenciamento de Estado**: TanStack Query

- **Roteamento**: React Router DOM

## 📦 Estrutura do Projeto

```

├── src/

│ ├── components/ # Componentes React reutilizáveis

│ │ ├── ChatInterface.tsx # Interface de chat com IA

│ │ └── DocumentUpload.tsx # Upload e análise de documentos

│ ├── pages/ # Páginas da aplicação

│ │ ├── Index.tsx # Página inicial

│ │ ├── Dashboard.tsx # Dashboard do cidadão

│ │ └── DocumentAnalyticsDashboard.tsx # Dashboard do governo

│ └── integrations/ # Integrações com serviços externos

│ └── supabase/ # Cliente Supabase

├── supabase/

│ └── functions/ # Edge Functions

│ ├── chat/ # Função de chat com IA

│ └── ocr-extract/ # Função de extração OCR

└── public/ # Arquivos estáticos

```

## 🔐 Segurança e Privacidade

- Todos os dados são armazenados de forma segura no backend

- Consentimento explícito para processamento de dados pessoais

- Comunicação criptografada (HTTPS)

- Conformidade com LGPD (Lei Geral de Proteção de Dados)

## 📋 Critérios de Elegibilidade

O programa atende exclusivamente:

- Moradias afetadas por eventos climáticos (enchentes, vendavais, deslizamentos, etc.)

- Comprovação através de documentação apropriada

## 🤖 Fluxo do Assistente Virtual

1.  **Confirmação de Região**: Validação de estado e município

2.  **Dados do Evento**: Data e tipo do evento climático

3.  **Validação de CPF**: Verificação de elegibilidade

4.  **Orientação Documental**: Lista de documentos necessários e instruções de envio

## 💻 Como Executar Localmente

```bash

# Instalar dependências

npm  install



# Iniciar servidor de desenvolvimento

npm  run  dev



# Acessar aplicação

http://localhost:8080

```

## 🌐 Deploy

A aplicação está hospedada e pode ser acessada através do Lovable.

Para fazer deploy de novas versões:

1. Acesse o projeto no [Lovable](https://lovable.dev/projects/55640eda-de7f-4ea0-a13a-d1ffe0dc11e7)

2. Clique em "Publish" no canto superior direito

## 📞 Suporte

Para dúvidas sobre o programa de auxílio reconstrução, entre em contato com:

- Defesa Civil do seu município

- Assistência Social local

## 📄 Licença

Este projeto foi desenvolvido para atender às necessidades do programa público de auxílio.

---

**Desenvolvido por:**

- Isabella Luiza (contateisabellacostavicente@gmail.com)

- Melody Rodrigues (melodyrodrigues@gmail.com)

- Peterson Fontinhas (petersonfontinhas@gmail.com)

- Sarah Bandeira (sarahbandeira@me.com)

**com ❤️ para ajudar a reconstruir vidas**
