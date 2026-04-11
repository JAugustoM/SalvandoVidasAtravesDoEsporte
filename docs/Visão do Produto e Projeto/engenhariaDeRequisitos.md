# Engenharia de Requisitos

## 4.1 Atividades e Técnicas de ER
Abaixo, detalhamos as atividades da Engenharia de Requisitos (ER) associadas às técnicas que serão utilizadas no contexto do RAD, cujo foco é o engajamento contínuo do cliente por meio de prototipagem e desenvolvimento em ciclos curtos

**Planejamento de Requisitos**

- **Elicitações e Descoberta:**
    - **Workshop JAD (Joint Application Design):** Sessões de trabalho colaborativo e intensivo envolvendo a equipe de desenvolvimento, o cliente e os usuários finais para levantar rapidamente as necessidades de negócio, mapear as funcionalidades centrais do sistema e alinhas as expectativas gerais do sistema.
    - **Entrevistas e Brainstorming:** Utilizadas no início do projeto e a cada iteração para capturar as dores do usuários e propor soluções em conjunto com os stakeholders.

- **Análise e Consenso:**
    - **Priorização MoSCoW:** Técnica de priorização compatível com ambientes iterativos como o RAD, responsável por classificar os requisitos em *Must have* (essenciais para o protótipo/MVP), *Should have*, *Could have* e *Won't have*, garantindo que a equipe foque no que gera mais valor em menos tempo.
    - **Timeboxing:** Alinhado à natureza iterativa do RAD, consiste na fixação de prazos rigorosos para cada fase de prototipagem e construção, assegurando que o escopo caiba no tempo de desenvolvimento estipulado e auxiliando a equipe e o cliente a chegarem a um consenso sobre o que é essencial e factível em cada iteração.

- **Declaração de Requisitos:**
    - **Temas, Épicos e User Stories (Histórias de Usuário) e Critérios de Aceitação:** Como complemento à abordagem de prototipação do RAD e para dar suporte ao caráter ágil da abordagem híbrida, os requisitos podem ser organizados em temas e épicos e detalhados no formato de histórias focadas no usuário, acompanhadas de critérios de aceitação claros (Definition of Ready e Definition of Done). Essa estrutura auxilia na organização do backlog inicial e no alinhamento com os stakeholders, especialmente usuários com baixo letramento digital.

**Design do Usuário (Prototipagem iterativa)**

- **Representação de Requisitos:**
    - **Prototipagem Rápida (Wireframes e Mockups):** No RAD, a representação visual é a técnica central para tornar os requisitos concretos, visíveis e validáveis.Consiste na criação iterativa de protótipos de interface, telas e fluxos navegáveis, que servem como principal modelo visual para que os stakeholders compreendam, validem e refinem a solução antes do desenvolvimento completo.

- **Verificação e Validação de Requisitos:**
    - **Validação de Protótipos com o Cliente:** Sessões onde os *protótipos* são testados em sessões nas quais o cliente interage diretamente com as interfaces e fluxos propostos. O feedback imediato, obtido de forma visual e prática, permite validar se o entendimento dos requisitos, incluindo as histórias de usuário associadas está correta e alinhada às necessidades reais.

- **Elicitação e Descoberta (Refinamento):**
    - **Refinamento Iterativo (Sessões JAD contínuas):** Durante a avaliação dos protótipos, novos requisitos ou ajustes (*refinamentos*) são descobertos iterativamente a partir da interação visual do usuário.

**Construção Rápida (Iterativa)**

- **Organização e Atualização:**
    - **Gerenciamento e Refinamento de Backlog (Grooming):** Manutenção contínua da lista de requisitos (backlog) ao longo dos ciclos iterativos, ajustando prioridades e detalhando histórias à medida que novos aprendizados surgem a partir dos protótipos avaliados.

- **Verificação e Validação de Requisitos:**
    - **Checklist e Revisão de Critérios de Aceitação:** Verificação técnica realizada ao final de cada ciclo de construção rápida, assegurando que o incremento de software atende aos critérios de aceitação definidos e à Definition of Done (DoD), validando o comportamento esperado e o alinhamento com a história de usuário associada.

**Transição (Cutover)**

- **Verificação e Validação de Requisitos:**
    - **Teste de Aceitação pelo Cliente (UAT) / Homologação:** Validação final do sistema consolidado com o cliente e usuários em ambiente de homologação, garantindo que o produto atende às necessidades que motivaram o projeto antes do lançamento oficial.

## 4.2 Engenharia de Requisitos e o RAD

| Fases do Processo RAD | Atividades ER | Prática | Técnica | Resultado Esperado |
| :--- | :--- | :--- | :--- | :--- | 
| Planejamento de Requisitos | Elicitação e Descoberta | Levantamento intensivo de necessidades | Workshops JAD, Entrevistas e Brainstorming | Escopo preliminar, funcionalidades mapeadas e objetivos alinhados com stakeholders. |
| | Análise e Consenso | Definição de Escopo e Prioridade | Priorização MoSCoW, Timeboxing | Requisitos críticos (Must have) priorizados e acordados para o primeiro protótipo, limitados pelo prazo. |
| | Declaração de Requisitos | Registro Inicial de Requisitos | Temas, Épicos e User Stories | Backlog inicial estruturado com histórias focadas nas necessidades do usuário. | 
| Design do Usuário (Prototipagem Iterativa) | Representação de Requisitos | Criação de Interfaces Visuais | Prototipagem Rápida (Wireframes e Mockups) | Protótipos de interface e fluxos navegáveis desenvolvidos para avaliação visual do cliente. |
| | Verificação e Validação | Avaliação com Stakeholders |Validação de Protótipos com o Cliente | Confirmação visual de que o design atende à história de usuário antes da codificação. |
| | Elicitação e Descoberta | Refinamento Iterativo | Refinamento Iterativo (Sessões JAD Contínuas) | Novos requisitos ou ajustes detalhados a partir da interação do cliente com os protótipos. |
| Construção Rápida (Iterativa) | Organização e Atualização | Manutenção do Backlog | Gerenciamento e Refinamento de Backlog (Grooming) | Histórias de usuário detalhadas, estimadas e ajustadas no backlog (DEEP) conforme as mudanças da fase de design. |
| | Verificação e Validação | Testes de Funcionalidade | Revisão de Critérios de Aceitação e Checklist | Incremento de software construído rapidamente verificado contra a Definition of Done (DoD). |
| Transição (Cutover) | Verificação e Validação | Homologação Final | Teste de Aceitação pelo Cliente (UAT) / Homologação | Produto consolidado validado no ambiente de homologação e aprovado para lançamento oficial. |