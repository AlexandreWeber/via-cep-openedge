USING OpenEdge.Net.HTTP.ClientBuilder.
USING OpenEdge.Net.HTTP.RequestBuilder.
USING OpenEdge.Net.HTTP.lib.ClientLibraryBuilder.
USING OpenEdge.Net.HTTP.IHttpRequest.
USING PROGRESS.json.ObjectModel.*.

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

PROCEDURE buscarPeloEndereco:
    DEFINE INPUT  PARAMETER p-uf         AS CHARACTER  NO-UNDO.
    DEFINE INPUT  PARAMETER p-cidade     AS CHARACTER  NO-UNDO.
    DEFINE INPUT  PARAMETER p-logradouro AS CHARACTER  NO-UNDO.

    DEFINE OUTPUT PARAMETER TABLE FOR ttCep.

    DEFINE VARIABLE oHttpClient     AS OpenEdge.Net.HTTP.IHttpClient         NO-UNDO.
    DEFINE VARIABLE c-url           AS CHARACTER                             NO-UNDO.
    DEFINE VARIABLE oEntityArray    AS JsonArray                             NO-UNDO.
    DEFINE VARIABLE i               AS INTEGER     NO-UNDO.

    ASSIGN c-url = "https:~/~/viacep.com.br/ws/" + p-uf + "/" + p-cidade + "/" + p-logradouro + "/json/".

    oHttpClient = ClientBuilder:Build():UsingLibrary(ClientLibraryBuilder:Build():sslVerifyHost(NO):LIBRARY):Client.
    oEntityArray = CAST(oHttpClient:Execute(RequestBuilder:Get(c-url):Request):Entity, JSONArray). 
    
    DO i = 1 TO oEntityArray:LENGTH:
        CREATE ttCep.
        ASSIGN ttCep.cep         = IF oEntityArray:getJsonObject(i):HAS("cep")         THEN oEntityArray:getJsonObject(i):getCharacter("cep")           ELSE ""
               ttCep.logradouro  = IF oEntityArray:getJsonObject(i):HAS("logradouro")  THEN oEntityArray:getJsonObject(i):getCharacter("logradouro")    ELSE ""
               ttCep.complemento = IF oEntityArray:getJsonObject(i):HAS("complemento") THEN oEntityArray:getJsonObject(i):getCharacter("complemento")   ELSE ""
               ttCep.bairro      = IF oEntityArray:getJsonObject(i):HAS("bairro")      THEN oEntityArray:getJsonObject(i):getCharacter("bairro")        ELSE ""
               ttCep.localidade  = IF oEntityArray:getJsonObject(i):HAS("localidade")  THEN oEntityArray:getJsonObject(i):getCharacter("localidade")    ELSE ""
               ttCep.uf          = IF oEntityArray:getJsonObject(i):HAS("uf")          THEN oEntityArray:getJsonObject(i):getCharacter("uf")            ELSE ""
               ttCep.unidade     = IF oEntityArray:getJsonObject(i):HAS("unidade")     THEN oEntityArray:getJsonObject(i):getCharacter("unidade")       ELSE ""
               ttCep.ibge        = IF oEntityArray:getJsonObject(i):HAS("ibge")        THEN oEntityArray:getJsonObject(i):getCharacter("ibge")          ELSE ""
               ttCep.gia         = IF oEntityArray:getJsonObject(i):HAS("gia")         THEN oEntityArray:getJsonObject(i):getCharacter("gia")           ELSE "".
    END.
END.

PROCEDURE buscarPeloCep:
    DEFINE INPUT  PARAMETER p-cep AS CHARACTER NO-UNDO.
    DEFINE OUTPUT PARAMETER TABLE FOR ttCep.

    DEFINE VARIABLE oHttpClient AS OpenEdge.Net.HTTP.IHttpClient         NO-UNDO.
    DEFINE VARIABLE c-url       AS CHARACTER                             NO-UNDO.
    DEFINE VARIABLE oEntity     AS JsonObject                            NO-UNDO.

    ASSIGN c-url = "https:~/~/viacep.com.br/ws/" + p-cep + "/json/".

    oHttpClient = ClientBuilder:Build():UsingLibrary(ClientLibraryBuilder:Build():sslVerifyHost(NO):LIBRARY):Client.
    oEntity = CAST(oHttpClient:Execute(RequestBuilder:Get(c-url):Request):Entity, JSONObject). 

    IF oEntity:has("cep") THEN DO:
        CREATE ttCep.
        ASSIGN ttCep.cep         = IF oEntity:HAS("cep")         THEN oEntity:getCharacter("cep")           ELSE ""
               ttCep.logradouro  = IF oEntity:HAS("logradouro")  THEN oEntity:getCharacter("logradouro")    ELSE ""
               ttCep.complemento = IF oEntity:HAS("complemento") THEN oEntity:getCharacter("complemento")   ELSE ""
               ttCep.bairro      = IF oEntity:HAS("bairro")      THEN oEntity:getCharacter("bairro")        ELSE ""
               ttCep.localidade  = IF oEntity:HAS("localidade")  THEN oEntity:getCharacter("localidade")    ELSE ""
               ttCep.uf          = IF oEntity:HAS("uf")          THEN oEntity:getCharacter("uf")            ELSE ""
               ttCep.unidade     = IF oEntity:HAS("unidade")     THEN oEntity:getCharacter("unidade")       ELSE ""
               ttCep.ibge        = IF oEntity:HAS("ibge")        THEN oEntity:getCharacter("ibge")          ELSE ""
               ttCep.gia         = IF oEntity:HAS("gia")         THEN oEntity:getCharacter("gia")           ELSE "".
    END.
END PROCEDURE.
