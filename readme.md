# Projeto

Programa progress para consumo da api de CEP viaCep https://viacep.com.br/

## Como utilizar

O programa deve ser executado de forma persistente e então usar as procedures abaixo:

buscarPeloCep (input "cep", output table ttCep)

buscarPeloEndereco (input "uf", input "p-cidade", input "p-logradouro"output table ttCep)


```
/* Exemplo */
DEFINE VARIABLE h-cep AS HANDLE      NO-UNDO.

RUN via-cep.p PERSISTENT SET h-cep.

DEFINE TEMP-TABLE ttCEP NO-UNDO
    FIELD cep           AS CHARACTER
    FIELD logradouro    AS CHARACTER
    FIELD complemento   AS CHARACTER
    FIELD bairro        AS CHARACTER
    FIELD localidade    AS CHARACTER
    FIELD uf            AS CHARACTER
    FIELD unidade       AS CHARACTER
    FIELD ibge          AS CHARACTER
    FIELD gia           AS CHARACTER.

RUN buscarPeloCep IN h-cep (INPUT "89201299", 
                            OUTPUT TABLE ttCEP).

DELETE PROCEDURE h-cep.
```

### Pré-requisitos

Progress 11.7 e possuir a biblioteca %DLC%\gui\netlib\OpenEdge.Net.pl no propath:
https://documentation.progress.com/output/ua/OpenEdge_latest/index.html#page/dvpin%2Fmaking-http(s)-requests-from-abl-applications.html%23

