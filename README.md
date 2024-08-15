# Política de Gerenciamento do Ciclo de Vida do Índice (ILM) no Elasticsearch

Este repositório contém uma configuração de política de Gerenciamento do Ciclo de Vida do Índice (ILM) do Elasticsearch. O ILM é um recurso que permite automatizar o gerenciamento do ciclo de vida dos índices, ajudando a transitar os índices por diferentes fases com base em condições específicas.

## Visão Geral

### Objeto de Política

O objeto raiz, `policy`, define a política de ciclo de vida do índice e contém todas as fases e ações aplicáveis aos índices associados a essa política.

### Fases do Ciclo de Vida

Dentro da política, o objeto `phases` define as diferentes fases do ciclo de vida de um índice:

- **Fase Quente (Hot):** A primeira fase do ciclo de vida, onde índices ativos recebem uma grande quantidade de novos dados. Ações nesta fase otimizam o desempenho de gravação e consulta.
- **Fase Morna (Warm):** Fase intermediária onde os índices ainda são pesquisáveis, mas não recebem novos dados com a mesma frequência.
- **Fase Fria (Cold):** Fase onde os índices são menos acessados, otimizando custos de armazenamento.
- **Fase de Exclusão (Delete):** Define quando e como os índices devem ser excluídos.

### Configuração da Fase Quente (Hot)

- **`min_age`:** Define a idade mínima que um índice deve ter antes de passar para a próxima ação dentro da fase quente. Exemplo: `"min_age": "20m"` (20 minutos).
- **Ações na Fase Quente:**
  - **Rollover:** Permite que um índice seja "rolado" para um novo índice quando critérios como tamanho ou idade são atendidos.
    - **`max_size`:** Tamanho máximo que um índice pode atingir antes de acionar o rollover. Exemplo: `"max_size": "50gb"` (50GB).
    - **`max_age`:** Idade máxima que um índice pode atingir antes de acionar o rollover. Exemplo: `"max_age": "1d"` (1 dia).

### Configuração da Fase de Exclusão (Delete)

- **`min_age`:** Define a idade mínima que o índice deve ter antes de ser excluído. Exemplo: `"min_age": "20m"` (20 minutos).
- **Ações na Fase de Exclusão:**
  - **Delete:** Ação específica para remover o índice.

## Informações Adicionais

No Elasticsearch, um índice pode ter 1 ou mais shards primários. As políticas ILM são executadas a cada 10 minutos, então é normal que o índice tenha uma idade ligeiramente maior que a definida. O intervalo de verificação do ILM pode ser ajustado, mas isso pode gerar sobrecarga no ambiente. 

Sinta-se à vontade para personalizar esta política de acordo com seus requisitos específicos. Para mais informações, consulte a [documentação oficial do Elasticsearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-lifecycle-management.html).
