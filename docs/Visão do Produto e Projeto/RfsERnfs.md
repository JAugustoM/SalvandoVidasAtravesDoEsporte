# 8 Requisitos de Software

## 8.1 Lista de Requisitos Funcionais

Os requisitos funcionais descrevem as funcionalidades específicas que o sistema deve implementar para atender às necessidades da instituição Salvando Vidas Através do Esporte, realizado pela Segunda Igreja Batista do Recanto das Emas. A seguir, são apresentados o conjunto preliminar de requisitos.

**RF01 – Cadastrar alunos:** Permitir a inserção de um novo aluno no sistema, registrando seus dados pessoais e de matrícula para vinculação às atividades.

**RF02 – Editar dados do aluno:** Permitir a alteração das informações cadastrais de um aluno já registrado no sistema.

**RF03 – Inativar cadastro de aluno:** Permitir a alteração do status de um aluno para inativo, mantendo seu histórico, mas removendo-o das listas ativas.

**RF04 – Buscar dados do aluno:** Permitir a pesquisa dos dados de alunos cadastrados utilizando parâmetros como nome ou matrícula para localizar seus registros.

---

**RF05 – Cadastrar responsável legal:** Permitir a inserção dos dados de um responsável legal no sistema para posterior vinculação aos alunos.

**RF06 – Vincular responsável ao aluno:** Permitir a criação de uma relação no sistema entre o cadastro de um aluno e o de seu responsável legal.

**RF08 – Editar dados do responsável:** Permitir a modificação das informações pessoais e de contato de um responsável legal previamente cadastrado.

**RFXX - Inativar responsável:**

---

**RFXX - Cadastrar turma:**

**RFXX - Editar turma:**

**RFXX - Inativar turma:**

**RFXX - Buscar turmas:**

---

**RF09 – Registrar presença em aula:** Permitir a marcação de presença ou falta para os alunos associados a uma aula ou turma selecionada.

**RF10 – Registrar detalhes da aula:** Permitir a descrição das atividades realizadas e temas abordados em uma aula registrada no sistema.

**RF11 – Editar registro de presença:** Permitir a retificação do status de frequência de um aluno em uma aula após o lançamento inicial.

**RF12 – Consultar histórico de presença:** Permitir a visualização consolidada dos registros de frequência de um aluno ao longo de um período selecionado.

**RF15 – Listar alunos em risco de evasão:** Permitir a geração de uma relação dos alunos que atingiram os parâmetros de alerta para risco de evasão.

**RF17 – Cadastrar doação de kimonos:** Permitir a adição de novas unidades de kimonos ao controle de estoque, atualizando a quantidade disponível.

**RF19 – Inativar materiais danificados:** Permitir o registro da remoção de itens do estoque devido a danos ou perda, atualizando o inventário.

**RF20 – Consultar estoque disponível:** Permitir a verificação da quantidade atualizada de um determinado material ou equipamento no inventário.

**RF21 – Vincular empréstimo do kimono:** Permitir a vinculação da saída de um material do estoque a um aluno por um período determinado.

**RF23 – Desvincular devolução do kimono:** Permitir o registro do retorno de um material emprestado, reintegrando-o à contagem do estoque.

**RF25 – Registrar observações pedagógicas:** Permitir a inserção de apontamentos sobre o comportamento e desenvolvimento educacional do aluno.

**RF29 – Registrar orientações aos responsáveis:** Permitir a documentação das comunicações, diretrizes e feedbacks repassados aos responsáveis do aluno.

**RF26 – Visualizar orientações e observações:** Permitir a exibição cronológica de todas as observações e registros pedagógicos associados a um aluno.

**RF30 – Gerar relatório social:** Permitir a compilação e exportação dos dados sociais e informações de vulnerabilidade do aluno.

**RF38 – Listar alunos aniversariantes:** Permitir a filtragem e exibição dos alunos que completam ano de vida em um mês ou período determinado.

**RF40 – Exibir histórico de faixas:** Permitir a visualização do registro cronológico de todas as graduações e exames já realizados pelo aluno.

**RF42 – Cadastrar campeonato:** Permitir a documentação dos eventos competitivos dos quais o aluno participou, registrando as datas.

**RFXX - Editar campeonato:**

**RFXX - Inativar campeonato:**

**RFXX - Vincular aluno num campeonato:**

**RFXX - Desvincular aluno de um campeonato:**

**RF43 – Cadastrar usuário voluntário:** Permitir a inserção no sistema dos perfis de professores, monitores e demais colaboradores do projeto.

**RFXX - Inativar usuário voluntário:**

**RFXX - Editar dados do usuário voluntário:**

**RFXX - Buscar usuários voluntários:**


## 8.2 Lista de Requisitos Não Funcionais

**RNF01 - Usabilidade (Usability):** A interface de usuário deve ser totalmente responsiva, utilizando princípios de design fluido para se adaptar automaticamente a diferentes resoluções de tela e dispositivos. A experiência de uso não deve ser degradada em telas menores (smartphones e tablets), garantindo que botões, textos e menus permaneçam legíveis, acessíveis e operáveis sem a necessidade de zoom manual.

**RNF02 - Usabilidade (Usability):** A arquitetura de informação e a navegação do sistema devem ser otimizadas para que os usuários consigam acessar e executar as funcionalidades principais (como registrar presença, consultar estoque ou cadastrar alunos) em, no máximo, três cliques a partir da tela inicial. O design deve ser intuitivo o suficiente para evitar confusão de navegação e dispensar manuais complexos.

**RNF03 - Confiabilidade (Reliability):** O sistema deve registrar e manter logs detalhados e inalteráveis de todas as ações críticas e alterações em dados sensíveis. Esses logs devem incluir a identificação do usuário responsável pela ação, a data e hora exatas da ocorrência e o dado modificado, garantindo total rastreabilidade e facilitando processos de auditoria para proteção dos dados da instituição.

**RNF04 - Desempenho (Performance):** O sistema deve ser otimizado no backend e no banco de dados para garantir que operações de leitura, como a consulta, filtragem e carregamento de listas completas de alunos, sejam processadas e exibidas na interface do usuário em um tempo de resposta estritamente inferior a 2 segundos, mesmo durante picos de acessos simultâneos.

**RNF05 - Segurança (Security):** O sistema deve implementar um rigoroso controle de acesso baseado em papéis. Funcionalidades de escrita e exclusão, como alteração de dados cadastrais e remoção de registros, devem ser restritas exclusivamente a usuários autenticados com os perfis de "Instrutor" ou "Admin". Tentativas de acesso não autorizado a essas funções devem ser bloqueadas imediatamente.

**RNF06 - Suportabilidade (Supportability):** O sistema web deve funcionar de maneira consistente e sem perda de funcionalidades nos navegadores web modernos mais utilizados do mercado, incluindo Google Chrome, Mozilla Firefox e Safari (em suas versões mais recentes). A aplicação deve garantir estabilidade na comunicação cliente-servidor independentemente do sistema operacional base do dispositivo.

## 8.3 Matriz-síntese de rastreabilidade

A matriz, a seguir, representa a rastreabilidade entre objetivos específicos (OE), características de produto (CP), valor de negócio (VN), requisitos funcionais (RFs) e não funcionais (RNFs).

| Contribuição principal | Contribuição secundária | CP | VN | RFs relacionados | RNFs relacionados |
| :---: | :---: | :---: | :---: | :---: | :---: |
| OE01 | - | CP01 | VN01 | RF01, RF02, RF03, RF04, RF34, RF35, RF36, RF37, RF38 | RNF01, RNF03, RNF04, RNF05, RNF06 |
| OE01 | - | CP02 | VN02 | RF05, RF06, RF07, RF08 | RNF01, RNF03, RNF05 | 
| OE01 | - | CP03 | VN03 | RF43, RF44, RF45 | RNF01, RNF02, RNF04, RNF06 |
| OE02 | OE04 | CP04 | VN04 | RF09, RF10, RF11, RF12, RF13 | RNF01, RNF02, RNF04, RNF06 |
| OE02 | OE04 | CP05 | VN05 | RF14, RF15, RF16 | RNF03, RNF04, RNF05 |
| OE03 | - | CP06 | VN06 | RF17, RF18, RF19, RF20 | RNF01, RNF02, RNF06 |
| OE03 | - | CP07 | VN07 | RF21, RF22, RF23, RF24 | RNF01, RNF02, RNF03, RNF05 |
| OE04 | OE01 | CP08 | VN08 | RF25, RF26, RF27, RF28, RF29, RF39, RF40, RF41, RF42 | RNF01, RNF03, RNF05 |
| OE04 | OE02 | CP09 | VN09 | RF30, RF31, RF32, RF33 | RNF03, RNF04, RNF05 |

