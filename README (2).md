# Predição de Diabetes com R

Este projeto tem como objetivo construir e avaliar modelos de machine learning para prever a ocorrência de diabetes com base em dados clínicos. Utilizando a linguagem R, o projeto realiza análise exploratória, tratamento de outliers, e aplica algoritmos de classificação com validação cruzada.

## Dataset

O conjunto de dados utilizado é o **Pima Indians Diabetes Database**, que contém as seguintes variáveis:

- `Pregnancies`: Número de gestações
- `Glucose`: Concentração de glicose
- `BloodPressure`: Pressão arterial diastólica
- `SkinThickness`: Espessura da dobra cutânea do tríceps
- `Insulin`: Nível de insulina
- `BMI`: Índice de massa corporal
- `DiabetesPedigreeFunction`: Função de histórico familiar de diabetes
- `Age`: Idade
- `Outcome`: Diagnóstico de diabetes (0 = negativo, 1 = positivo)

O dataset é carregado com `file.choose()` ou pode ser armazenado previamente como `"data/diabetes.csv"`.

## Técnicas Utilizadas

- **Análise Exploratória de Dados (EDA)** com `ggplot2`
- **Tratamento de outliers** com base no intervalo interquartil (IQR)
- **Divisão treino/teste** utilizando `caTools`
- **Validação cruzada k-fold** com o pacote `caret`
- Modelagem com os algoritmos:
  - KNN (K-Nearest Neighbors) com busca de hiperparâmetros
  - Naive Bayes
  - SVM com kernel radial (Suport Vector Machines)

## Execução

### Instale os pacotes necessários:

```r
install.packages(c("dplyr", "caTools", "caret", "e1071", "ggplot2", "klaR", "kernlab"))
```

### Execute o script principal:

```r
source("diabetes_predicao_melhorado.R")
```

Durante a execução, será solicitado que você selecione o arquivo CSV contendo os dados.

## Resultados

- Comparação de desempenho entre modelos (KNN, Naive Bayes, SVM)
- Exibição da melhor configuração de hiperparâmetros
- Avaliação com matriz de confusão no conjunto de teste
- Exportação das predições para `resultados.csv`
- Predição com novos dados simulados

## Estrutura do Projeto

```
.
├── diabetes_predicao_melhorado.R
├── resultados.csv  # (gerado automaticamente após execução)
└── README.md
```